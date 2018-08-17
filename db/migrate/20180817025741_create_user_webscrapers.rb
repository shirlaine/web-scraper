class CreateUserWebscrapers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_webscrapers do |t|
      t.references :user, foreign_key: true
      t.references :webscraper, foreign_key: true
      t.timestamps   
    end
  end
end
