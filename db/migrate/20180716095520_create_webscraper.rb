class CreateWebscraper < ActiveRecord::Migration[5.1]
  def change
    create_table :webscrapers do |t|
      t.string :name, null: false
      t.text :content
      t.timestamps
    end
  end
end
