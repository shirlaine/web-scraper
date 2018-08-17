class UserWebscraper < ApplicationRecord
  belongs_to :user
  belongs_to :webscraper
end