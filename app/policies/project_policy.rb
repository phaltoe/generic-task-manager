class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.team_projects | user.projects
    end
  end

  def new?
    user
  end

  def create?
    user
  end

  def show?
    user.has_role? record, :view
  end

  def edit?
    user.has_role? record, :edit
  end

  def update?
    user.has_role? record, :edit
  end

  def destroy?
    user == record.owner
  end

  def edit_permissions?
    user.has_role? record, :edit
  end

  def add_team_members?
    user.has_role? record, :edit
  end

  def view_team_members?
    user.has_role? record, :view
  end
end
