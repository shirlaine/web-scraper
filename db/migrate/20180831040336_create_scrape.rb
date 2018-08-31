class CreateScrape < ActiveRecord::Migration[5.1]
  def change
    create_table :scrapes do |t|
      t.text :scraped_content, null: false
      t.references :webscraper, foreign_key: true
      t.timestamps
    end
  end
end
