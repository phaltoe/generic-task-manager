class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # TODO
      # Make policy include where owner OR where member of projet group
      scope.where(:owner => user)
    end
  end

end
