class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.team_projects | user.projects
    end
  end

  def new?
    user.present?
  end

  def show?
    record.owner == user or user.has_role? record, :view
  end

  def edit?
    record.owner == user or user.has_role? record, :edit
  end

  def update?
    record.owner == user or user.has_role? record, :edit
  end

  def destroy?
    record.owner == user or user.has_role? record, :edit
  end

  def edit_permissions?
    record.owner == user or user.has_role? record, :edit
  end

  def add_team_members?
    record.owner == user or user.has_role? record, :edit
  end
end
