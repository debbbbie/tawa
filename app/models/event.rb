class Event < ApplicationRecord

  validates :user, presence: true
  validates :eventable, presence: true
  validates :type, presence: true

  self.inheritance_column = nil
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  belongs_to :project

  default_scope { order(id: :desc) }

  before_validation :cache_project_id

  def to_s
    case type.to_sym
      when :create_team
        "#{user.nickname} 创建了团队 : #{eventable.name}"
      when :create_project
        "#{user.nickname} 创建了项目 : #{eventable.name}"
      when :create_todo
        "#{user.nickname} 创建了任务 : #{eventable.name}"
      when :destroy_todo
        "#{user.nickname} 删除了任务 : #{eventable.name}"
      when :finish_todo
        "#{user.nickname} 完成了任务 : #{eventable.name}"
      when :reopen_todo
        "#{user.nickname} 重新打开了任务 : #{eventable.name}"
      when :assign_user
        "#{user.nickname} 给 #{changed_to_user.nickname} 指派了任务 : #{eventable.name}"
      when :set_deadline
        "#{user.nickname} 将任务完成时间从 #{change_to ? '没有截止日期' : Time.parse(change_to).human_display} 修改为 #{Time.parse(change_to).human_display} : #{eventable.name}"
      when :create_comment
        "#{user.nickname} 评论了任务 : #{eventable.content}"
    end
  end

  def changed_to_user
    User.find_by_id change_to
  end

  def cache_project_id
    self.project_id = case eventable
                        when Project
                          eventable.id
                        when Comment
                          eventable.todo.project_id
                        when Todo
                          eventable.project_id
                        when Team
                          nil
                        else
                          nil
                      end if self.project_id.blank?
  end
end
