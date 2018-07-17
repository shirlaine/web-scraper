class UrlScrapersController < ApplicationController
  def index
    @urlscrapers = Webscraper.all
  end 

  def new
    @urlscraper = Webscraper.new
  end
  
  def create
    @urlscraper = Webscraper.new(url_scraper_params)
    if @urlscraper.save
      flash[:notice] = "Your url has been sucessfully saved"
      redirect_to url_scrapers_path
    else
      flash[:notice] = "Can't scrape if no URL!"
      render :new
    end
      
  end

  private

  def url_scraper_params
    params.require(:webscraper).permit(:name)
  end
end