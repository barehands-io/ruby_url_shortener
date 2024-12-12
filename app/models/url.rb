# app/models/url.rb
class Url < ApplicationRecord
  belongs_to :user
  has_many :clicks

  before_create :generate_short_url

  def generate_short_url
    self.short_url = SecureRandom.hex(5) unless self.short_url.present?
  end

  def expired?
    expiration_date.present? && expiration_date < Time.current
  end
end
