class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  scope :pending, -> { where(accepted: false) }
  enum :role => [:member, :leader]

end
