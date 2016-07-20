class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # TODO
      # Make policy include where owner OR where member of project group
      scope.where(:owner => user)
    end
  end

  def new?
    user.present?
  end

  def show?
    record.owner == user
  end

  def edit?
    record.owner == user
  end

  def update?
    record.owner == user
  end

  def destroy?
    record.owner == user
  end

  def edit_permissions?
    record.owner == user
  end

  def add_team_members?
    record.owner == user
  end
end
