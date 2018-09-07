class Scrape < ApplicationRecord
  belongs_to :webscraper
  validates :scrape_content, presence: true
end