class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.belongs_to :team
      t.string :name

      t.timestamps
    end
  end
end
