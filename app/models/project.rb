class Project < ActiveRecord::Base
  attr_accessor :emails_invited, :valid_emails, :invalid_emails

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :team_members, :dependent => :destroy
  has_many :tasks, :dependent => :destroy

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

  def add_owner_to_team_members
    team_member = self.team_members.build(user: self.owner, role: 'edit')
    team_member.save
  end

  def team_members=(attrs)
    attrs.each do |user_id, role_attrs|
      if role_attrs.has_value? 'None'
        if team_member = self.team_members.find_by(user_id: user_id)
          team_member.destroy
        end
      else
        team_member = self.team_members.find_or_create_by(user_id: user_id)
        team_member.role = role_attrs[:role].downcase
        team_member.save
      end
    end
  end
end
