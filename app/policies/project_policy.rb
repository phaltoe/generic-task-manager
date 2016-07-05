class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(:owner => current_user)
    end
  end
end
