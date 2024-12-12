# config/routes.rb
Rails.application.routes.draw do
  resources :urls, only: [ :create, :show ]
  get "/:short_url", to: "urls#redirect"
end

# app/controllers/urls_controller.rb
class UrlsController < ApplicationController
  def create
    @url = current_user.urls.new(url_params)
    if @url.save
      render json: @url, status: :created
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  def show
    @url = Url.find_by(short_url: params[:id])
    render json: @url
  end

  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url && !@url.expired?
      @url.clicks.create(ip_address: request.remote_ip, user_agent: request.user_agent)
      redirect_to @url.original_url
    else
      render plain: "URL not found or expired", status: :not_found
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url, :custom_alias, :expiration_date)
  end
end
