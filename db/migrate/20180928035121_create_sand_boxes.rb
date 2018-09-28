class CreateSandBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :sand_boxes do |t|
      t.string :title
      t.timestamps
    end
  end
end
