class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :team_users
  has_many :teams, through: :team_users
  has_many :owner_teams, foreign_key: :owner_id, class_name: 'Team'
  has_many :events
  has_many :accesses
  has_many :projects, through: :accesses
end
