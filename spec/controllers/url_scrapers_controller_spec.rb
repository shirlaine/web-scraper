require 'rails_helper'

RSpec.describe UrlScrapersController, type: :controller do
  
  # let(:webscraper) { create(:webscraper) }
  let(:webscraper) do
    webscraper = Webscraper.create(
      name: "https://smth.com/users",
      content: "some text content response"
    )
  end    

  describe 'Get#index' do
    let(:webscraper) { create(:webscraper) }
    it 'should return an empty array when no urls are scraped' do
      get :index
      expect(assigns(:urlscapers)).to be_nil
    end

    it 'should return an array with 1 element when 1 url is scraped' do
      webscraper = Webscraper.create(
      name: "https://smth.com/users",
      content: "some text content response"
      )
      # let(:webscraper) { create(:webscraper) }
      get :index
      expect(assigns(:urlscrapers).size).to eq 1  
    end

  end

end