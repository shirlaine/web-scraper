class Webscraper < ApplicationRecord

  has_many :user_webscrapers
  has_many :users, through: :user_webscrapers, dependent: :destroy
  has_many :scrapes
  validates :name, presence: true
  

  REFRESH_TIMEOUT = 10

  def fresh?
    return false if updated_at.nil?

    time_since_last_refresh < REFRESH_TIMEOUT
  end

  def time_since_last_refresh
    (Time.now - updated_at).floor
  end

  def time_to_next_refresh
    REFRESH_TIMEOUT - time_since_last_refresh
  end
end