class Project < ApplicationRecord
  validates :team, presence: true

  belongs_to :team
  has_many :events, as: :eventable
  has_many :accesses
  has_many :users, through: :accesses

  after_create do
    Event.create!(type: :create_project, user: team.owner, eventable: self)
  end
end
