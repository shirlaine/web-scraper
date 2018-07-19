class UrlScrapersController < ApplicationController
  def index
    @urlscrapers = Webscraper.all
  end 

  def new
    @urlscraper = Webscraper.new
  end
  
  def create

    @url = url_scraper_params[:name]
    ## call service to dl txt file
    @content = UrlscrapeActivateService.new(@url).scrape
    ## rails db save/update
     @urlscraper = Webscraper.new(name: @url, content: @content)
    # update
    @existing_url = Webscraper.find_by(name: @url)

    if @existing_url.present?
      @time_lapse = Time.now - @existing_url.updated_at
      ## set at 30 seconds in order to save to database again
      if @time_lapse > 12
        @existing_url.update(name: @url, content: @content)
        flash[:notice] = "Your url has been scraped again, content has been refreshed."
      # render :new
        redirect_to url_scrapers_path
      else
        flash[:notice] = "Your url has been just scraped ago, please wait #{30- @time_lapse.floor} seconds to try again."
        render :new
      end
    # save
    elsif @urlscraper.save 
      flash[:notice] = "Your url has been sucessfully scraped for the first time."
      redirect_to url_scrapers_path
    else
      flash[:notice] = "Can't scrape if no URL!"
      render :new
    end
    ## check time now if time does not exceed, save to database 
  end

  private

  def url_scraper_params
    params.require(:webscraper).permit(:name)
  end
end