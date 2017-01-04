require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:team) { create(:team, owner: user) }
  let(:project) { create(:project, team: team) }
  let(:team_user) { create(:team_user, team: team, user: user) }
  let(:todo) { create(:todo, project: project, user: user) }
  describe :events do

    describe :team do
      it :create_team do
        team

        event = user.events.first
        expect(event.type).to eq 'create_team'
        expect(event.eventable).to eq team
        expect(event.to_s).to eq "#{user.nickname} 创建了团队 : #{team.name}"
      end
    end

    describe :project do
      it :create_project do
        project

        event = user.events.first
        expect(event.type).to eq 'create_project'
        expect(event.eventable).to eq project
        expect(event.to_s).to eq "#{user.nickname} 创建了项目 : #{project.name}"
      end
    end

    describe :todo do
      it :create_todo do
        todo

        event = user.events.first
        expect(event.type).to eq 'create_todo'
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 创建了任务 : #{todo.name}"
      end

      it :destroy_todo do
        todo.destroy
        event = user.events.first
        expect(event.type).to eq 'destroy_todo'

        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 删除了任务 : #{todo.name}"
      end

      it :finish_todo do
        todo.update_attributes(finished_at: Time.now)
        event = user.events.first
        expect(event.type).to eq 'finish_todo'
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 完成了任务 : #{todo.name}"
      end

      it :reopen_todo do
        todo.update_attributes(finished_at: Time.now)
        todo.update_attributes(finished_at: nil)
        event = user.events.first
        expect(event.type).to eq 'reopen_todo'
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 重新打开了任务 : #{todo.name}"
      end

      it :assign_user do
        todo
        todo.update_attributes(assigned_user: user)
        event = user.events.first
        expect(event.type).to eq 'assign_user'
        expect(event.change_from).to be_nil
        expect(event.change_to).to eq user.id.to_s
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 给 #{user.nickname} 指派了任务 : #{todo.name}"
      end

      it :reassign_user do
        user2 = create(:user)
        team_user2 = create(:team_user, team: team, user: user2)

        todo.update_attributes(assigned_user: user)
        todo.update_attributes(assigned_user: user2)
        event = user.events.first
        expect(event.type).to eq 'assign_user'
        expect(event.change_from).to eq user.id.to_s
        expect(event.change_to).to eq user2.id.to_s
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 给 #{user2.nickname} 指派了任务 : #{todo.name}"
      end

      it :set_deadline do
        todo.update_attributes(deadline: 1.day.since)
        event = user.events.first
        expect(event.type).to eq 'set_deadline'
        expect(event.change_from).to be_nil
        expect(event.change_to).to eq 1.day.since.to_s
        expect(event.eventable).to eq todo
        expect(event.to_s).to eq "#{user.nickname} 将任务完成时间从 没有截止日期 修改为 明天 : #{todo.name}"
      end

      it :comment do
        comment = create(:comment, user: user, todo: todo)
        event = user.events.first
        expect(event.type).to eq 'create_comment'
        expect(event.eventable).to eq comment
        expect(event.to_s).to eq "#{user.nickname} 评论了任务 : #{comment.content}"
      end
    end
  end
end
