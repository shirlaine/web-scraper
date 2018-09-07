require 'rails_helper'

RSpec.describe UrlScrapersController, type: :controller do

  # let(:webscraper) { create(:webscraper) }
  # let(:webscraper) do
  #   webscraper = Webscraper.create(
  #     name: "https://smth.com/users",
  #     content: "some text content response"
  #   )
  # end

  describe 'Get#index' do
    it 'should return an empty array when no urls are scraped' do
      get :index
      expect(response.code).to eq "200"
      expect(assigns(:urlscapers)).to be_nil
    end

    it 'should return an array with 3 element when 3 url is scraped' do
      create_list(:webscraper, 3)
      get :index
      expect(response.code).to eq "200"
      expect(assigns(:urlscrapers).size).to eq 3
    end
  end

  describe 'Get#new' do
    context "when initialized" do
      # let(:webscraper) { build(:webscraper )}
      xit 'should return a new instance of a url' do
        get :new
        expect(assigns(:urlscraper)).to be_a_new(Webscraper)
      end
    end
  end

  describe 'Post#create' do
    # Webscraper.create(
    # name: "https://smth.com/users",
    # content: "some text content response"
    # )
    # let(:webscraper) { create(:webscraper) }
    before do
      post :create, params: { webscraper: { name: "smth" } }
    end
    ## happy path
    ### calls service object, flash message and redirect
    xit { expect(Webscraper.count).to eq(1) }
    ## unhappy path
    ### calls service object, rescues error, flash message and render new
  end

end

## question: when and how to use factories and when to use Webscraper.create?
## test for model methods?
## test for create