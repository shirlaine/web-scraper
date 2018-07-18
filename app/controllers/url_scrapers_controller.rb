class UrlScrapersController < ApplicationController
  def index
    @urlscrapers = Webscraper.all
  end 

  def new
    @urlscraper = Webscraper.new
  end
  
  def create
    @urlscraper = Webscraper.new(url_scraper_params)
    ## TO DO
    ### check 
    ## doing RequesterService.new(url).call will give the response
    ## you want to get the params(url input from view) into the RequesterService
    if @urlscraper.save
      flash[:notice] = "Your url has been sucessfully saved"
      ## scrape file frm URL
      ## save content into text file
      ## Download file 

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