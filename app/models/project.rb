class Project < ActiveRecord::Base
  attr_accessor :emails_invited, :valid_emails, :invalid_emails

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :team_members, :dependent => :destroy

  validates :title,
    :presence => true,
    :length => {
      :in => 6..155
    },
    :uniqueness => { :scope => :owner }
  validates :description,
    :presence => true,
    :length => {
      :in => 20..400
    }
  validates :owner, :presence => true

  after_create :add_owner_to_team_members

  def add_owner_to_team_members
    team_member = self.team_members.build(user: self.owner, role: 'edit')
    team_member.save
  end
end
