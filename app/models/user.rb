class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:github]

  has_one :profile, :dependent => :destroy, :inverse_of => :user
  has_many :projects, :foreign_key => "user_id", dependent: :destroy
  has_many :team_memberships, :class_name => 'TeamMember'
  has_many :team_projects, :through => :team_memberships, :source => :project, dependent: :destroy

  validates_associated :profile, :on => :create

  delegate :username, :to => :profile
  delegate :website, :to => :profile

  default_scope { where(:active => true) }


  def active?
    active
  end

  def profile_attributes=(attrs)
    if attrs.keys.include? 'id'
      self.profile.update(attrs)
    else
      self.create_profile(attrs)
    end
  end

  def self.not_on_team(project)
    self.find_by_sql(
      ["SELECT users.* FROM users
      LEFT OUTER JOIN team_members
      ON users.id = team_members.user_id
      AND team_members.project_id = ?
      WHERE team_members.user_id IS NULL",
      project.id]
    )
  end

  def has_role?(record, role)
    unless team_membership = TeamMember.where(user: self, project: record).first
      return record.owner == self ? true : false
    end

    if role == :edit
      team_membership.role == 'edit' || record.owner == self
    elsif role == :view
      team_membership.role == 'view' || team_membership.role == 'edit' || record.owner == self
    else
      false
    end
  end

  def self.from_omniauth(auth)
    if github_user = where(provider: auth.provider, uid: auth.uid).take
      github_user
    elsif existing_user = where(email: auth.info.email).take
      if existing_user.update(provider: auth.provider, uid: auth.uid)
        existing_user
      else
        raise "error updating existing user with github auth"
      end
    else
      github_user = User.create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.uid = auth.uid
        user.provider = auth.provider
      end
      github_user.create_profile(username: "#{auth.info.nickname}#{(0...4).map { rand(26) }.join}")
      github_user
    end
  end

  def self.new_from_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
