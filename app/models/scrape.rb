class Scrape < ApplicationRecord
  belongs_to :webscraper
  validates :scraped_content, presence: true
end