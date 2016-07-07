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
    user.present? && record.owner == user
  end

  def edit?
    user.present? && record.owner == user
  end

  def update?
    user.present? && record.owner == user
  end

  def destroy?
    user.present? && record.owner == user
  end
end
