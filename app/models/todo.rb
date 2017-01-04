class Todo < ApplicationRecord
  acts_as_paranoid without_default_scope: true
  has_many :events, as: :eventable
  belongs_to :project
  belongs_to :assigned_user, class_name: 'User'

  attr_accessor :user

  after_create do
    Event.create!(type: :create_todo, user: user, eventable: self)
  end

  after_destroy do
    Event.create!(type: :destroy_todo, user: user, eventable: self)
  end

  after_update do
    if finished_at_changed?
      if finished_at.present?
        Event.create!(type: :finish_todo, user: user, eventable: self)
      else
        Event.create!(type: :reopen_todo, user: user, eventable: self)
      end
    end

    if assigned_user_id_changed?
      Event.create!(type: :assign_user, user: user, eventable: self,
                    change_from: self.assigned_user_id_change[0], change_to: self.assigned_user_id_change[1])
    end

    if deadline_changed?
      Event.create!(type: :set_deadline, user: user, eventable: self,
                    change_from: self.deadline_change[0], change_to: self.deadline_change[1])
    end
  end
end
