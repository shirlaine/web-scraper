class ScrapeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false #retry over and over if fails

  def perform(start_date)
    puts "SideKiq is currently running a scrape job that started at #{start_date}"
    # put scrape job here
    save_model
  end

  private

  def save_model
    SandBox.create(title: "#{Time.now}")
  end

  # put scrape job here

end
