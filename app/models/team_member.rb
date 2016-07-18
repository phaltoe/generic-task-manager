class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  enum :role => [:view, :edit]
end