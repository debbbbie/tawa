class Team < ApplicationRecord
  validates :owner, presence: true

  has_many :team_users
  has_many :users, through: :team_users
  has_many :events, as: :eventable

  belongs_to :owner, class_name: 'User'

  after_create do
    Event.create!(type: :create_team, user: owner, eventable: self)
  end
end
