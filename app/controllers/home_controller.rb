class HomeController < ApplicationController

  def index
    current_user = User.first

    @events = Event.where(project: current_user.projects).or(Event.where(project: nil, eventable: current_user.teams)).limit(5)
    if params[:maxid]
      @events = @events.where("id < ?", params[:maxid])
    end

    respond_to do |format|
      format.html
      format.json do
        render json: @events.map { |e| {id: e.id, name: e.to_s} }
      end
    end
  end
end
