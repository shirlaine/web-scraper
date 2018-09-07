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

    context "name is nil" do
      let(:scraper) { build(:webscraper, name: nil) }
      let(:scraper_service) { SaveScraperService.new(scraper) }

      it "should raise an error if no url" do
        expect { scraper_service.fetch! }.to raise_error SaveScraperService::NoUrlError
      end
    end

    context "name is not nil" do
      let(:scraper) { create(:webscraper, name: "http://www.google.com") }
      let(:scraper_service) { SaveScraperService.new(scraper) }

      context "urlscraper is fresh" do
        before(:each) do
          allow(scraper).to receive(:fresh?).and_return true
        end

        it "should raise a not fresh error if recently scraped" do
          expect { scraper_service.fetch! }.to raise_error SaveScraperService::RecentlyScrapedError
        end
      end

      context "urlscraper is not fresh" do
        before(:each) do
          allow(scraper).to receive(:fresh?).and_return false
        end

        it "should raise and error if the scraper update fails" do
          allow(scraper).to receive(:update).and_return false
          expect { scraper_service.fetch! }.to raise_error SaveScraperService::DatabaseError
        end

        it "should save a scrape to the database" do
          content = "some content"
          allow(scraper_service).to receive(:get_content).and_return(content)
          scraper_service.fetch!
          scrape = Webscraper.last
          expect(scrape.content).to eq content
        end
      end
    end
  end
end
