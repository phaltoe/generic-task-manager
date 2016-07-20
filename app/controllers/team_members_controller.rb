class TeamMembersController < ApplicationController
  def new
    @project = Project.find_by(id: params[:project_id])
  end
    
end
