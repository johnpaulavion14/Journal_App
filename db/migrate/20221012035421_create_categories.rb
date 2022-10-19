class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :category
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :categories, :user_id
  end
end
