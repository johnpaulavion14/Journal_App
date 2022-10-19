class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task
      t.time :time
      t.date :date
      t.integer :category_id

      t.timestamps
    end
    add_index :tasks, :category_id
  end
end
