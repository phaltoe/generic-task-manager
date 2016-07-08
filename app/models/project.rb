class Project < ActiveRecord::Base
  attr_accessor :emails_invited

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :team_members

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

  after_create :add_owner_to_team_members, :send_invites

  def add_owner_to_team_members
    team_member = self.team_members.build(user: self.owner, role: 'leader')
    team_member.save
  end

  def send_invites
    return if self.emails_invited.blank?

    valid_emails, invalid_emails = self.emails_invited.split(', ').partition { |email| email[/@/]}

    valid_emails.each do |email|
      if user = User.find_by(:email => email)
        self.team_members.create(user: user, role: 'member')
      else
        self.team_members.create(role: 'member', invited_email: email)
      end
    end
  end
end
