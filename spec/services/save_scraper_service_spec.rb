require 'rails_helper'

RSpec.describe SaveScraperService do

  # bad, worthless spec
  describe ".new" do
    it "should assign urlscraper" do
      scraper = Webscraper.new
      scraper_service = SaveScraperService.new(scraper)
      expect(scraper_service.instance_variable_get(:@urlscraper)).to eq scraper
    end
  end


  describe ".fetch!" do
    it "should raise an error if no url" do
      scraper = Webscraper.new(name: nil)
      scraper_service = SaveScraperService.new(scraper)
      expect { scraper_service.fetch! }.to raise_error SaveScraperService::SaveScraperError
    end

    it "should raise a not fresh error if recently scraped" do
      scraper = create(:webscraper, name: "http://www.google.com")
      allow(scraper).to receive(:fresh?).and_return true
      scraper_service = SaveScraperService.new(scraper)
      expect { scraper_service.fetch! }.to raise_error SaveScraperService::SaveScraperError
    end

    it "should raise and error if the scraper update fails" do
      scraper = create(:webscraper, name: "http://www.google.com")
      allow(scraper).to receive(:fresh?).and_return false
      allow(scraper).to receive(:update).and_return false

      scraper_service = SaveScraperService.new(scraper)
      expect { scraper_service.fetch! }.to raise_error SaveScraperService::SaveScraperError
    end

    it "should save a scrape to the database" do
      scraper = create(:webscraper, name: "http://www.google.com")
      allow(scraper).to receive(:fresh?).and_return false
      scraper_service = SaveScraperService.new(scraper)

      allow(scraper_service).to receive(:get_content).and_return("some content")
      scraper_service.fetch!

      scrape = Webscraper.last
      expect(scrape.content).to eq "some content"
    end
  end
end
