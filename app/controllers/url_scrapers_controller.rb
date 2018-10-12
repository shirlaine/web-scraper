class UrlScrapersController < ApplicationController
  before_action :fetch_scraper, only: [:create]
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @urlscrapers = Webscraper.all
    ## find a way to get the obj from s3 to an instance variable in index
    ## find the bucket
    # find the object, return 
  end 

  def new
    @urlscraper = Webscraper.new
    @urlwebscraper = UserWebscraper.new
  end
  
  def create
    SaveScraperService.new(@urlscraper).fetch!
    @urlwebscraper = UserWebscraper.create(user: current_user, webscraper: @urlscraper)
    # @scraped = Scrape.create(webscraper: @urlscraper, scrape_content: @urlscraper.content)

    ScrapeWorker.perform_async("27/9/2018")
    ## fix logic here webscraper != @urlscraper
    @scraped = Scrape.create(webscraper: @urlscraper, scrape_content: "some content")
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('rails-learning-s').object("shir/#{@scraped.id}")
    obj.put(body: @urlscraper.content)

    flash[:notice] = "Your url has been scraped, content has been refreshed."
    redirect_to url_scrapers_path
  rescue StandardError => e
    flash.now[:notice] = e.message
    render :new
  end

  private

  def fetch_scraper
    @urlscraper = Webscraper.where(name: url_scraper_params[:name]).first_or_initialize
  end

  def url_scraper_params
    params.require(:webscraper).permit(:name)
  end
end