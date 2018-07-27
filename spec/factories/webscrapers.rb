FactoryBot.define do
  factory :webscraper do
    sequence(:name) { |n| "https://api.github.com/users/#{n}" }
    content "some response"
  end
end