class TaskPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #   end
  # end

  def new?
    user.has_role? record.project, :edit
  end

  def create?
    user.has_role? record.project, :edit
  end

  def show?
    user.has_role? record.project, :view
  end

  def edit?
    user.has_role? record.project, :edit
  end

  def update?
    user.has_role? record.project, :edit
  end

  def destroy?
    user.has_role? record.project, :edit
  end

  def toggle_complete?
    user.has_role? record.project, :edit
  end
end
