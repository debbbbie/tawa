class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string  :type

      t.integer :eventable_id
      t.string  :eventable_type

      t.string :change_from
      t.string :change_to

      t.timestamps
    end
    add_index :events, [:eventable_type, :eventable_id]
  end
end
