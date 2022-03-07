class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.string :rating
      t.integer :total_time

      t.timestamps
    end
  end
end
