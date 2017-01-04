class CreateTeamUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.belongs_to :user
      t.belongs_to :team

      t.timestamps
    end
  end
end
