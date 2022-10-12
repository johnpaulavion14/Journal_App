class AddFieldsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :category_id, :integer
    add_index :tasks, :category_id
  end
end
