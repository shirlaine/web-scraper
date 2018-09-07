class SaveScraperService
  class NoUrlError < StandardError; end
  class DatabaseError < StandardError; end
  class RecentlyScrapedError < StandardError; end

  NO_URL_ERROR = "Can't scrape if no URL!"
  DATABASE_ERROR = "Ouch... unable to save!"
  NOT_FRESH_ERROR = "Your url has been just scraped before, please wait %s seconds to try again."

  def initialize(urlscraper)
    @urlscraper = urlscraper
  end

  def fetch!
    raise NoUrlError.new(NO_URL_ERROR) if @urlscraper.name.nil?

    if @urlscraper.fresh? #if not fresh, scrape, still fresh don't scrape
      message = NOT_FRESH_ERROR % [@urlscraper.time_to_next_refresh]
      raise RecentlyScrapedError.new(message)
    end

    unless @urlscraper.update(content: get_content(@urlscraper.name))
      raise DatabaseError.new(DATABASE_ERROR)
    end
  end
  
  private

  def get_content(url)
    UrlscrapeActivateService.new(url).scrape
  end
end
