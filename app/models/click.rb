# app/models/click.rb
class Click < ApplicationRecord
  belongs_to :url
end

# app/controllers/urls_controller.rb
class UrlsController < ApplicationController
  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url && !@url.expired?
      @url.clicks.create(ip_address: request.remote_ip, user_agent: request.user_agent)
      redirect_to @url.original_url
    else
      render plain: "URL not found or expired", status: :not_found
    end
  end
end
