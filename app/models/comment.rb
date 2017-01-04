class Comment < ApplicationRecord
  has_many :events, as: :eventable
  belongs_to :todo
  belongs_to :user

  after_create do
    Event.create!(type: :create_comment, user: user, eventable: self)
  end
end
