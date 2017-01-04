require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }
  let(:team) { create(:team, owner: user) }
  let(:team_user) { create(:team_user, team: team, user: user) }
  let(:project) { create(:project, team: team) }
  let(:access) { create(:access, project: project, user: user) }
  let(:todo) { create(:todo, project: project, user: user) }


  it 'index' do
    user
    team
    team_user
    project
    access
    todo

    get :index, params: { format: 'json' }
    expect(response.body).to match team.name
    expect(response.body).to match todo.name
  end
end
