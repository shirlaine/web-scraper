class ScrapeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false #retry over and over if fails

  def perform(start_time)
    puts "SideKiq is currently running a scrape job that started at #{start_time}"
    # Do something
  end
end
