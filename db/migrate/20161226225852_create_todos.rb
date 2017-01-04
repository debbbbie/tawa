class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.belongs_to :project

      t.datetime :deadline
      t.belongs_to :assigned_user, class_name: 'User'

      t.datetime :finished_at
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :todos, :deleted_at
  end
end
