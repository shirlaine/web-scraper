class UrlScrapersController < ApplicationController
  
  before_action :fetch_scraper, only: [:create]

  def index
    @urlscrapers = Webscraper.all
  end 

  def new
    @urlscraper = Webscraper.new
  end
  
  def create
    SaveScraperService.new(@urlscraper).fetch!
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