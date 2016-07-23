class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, :dependent => :destroy, :inverse_of => :user
  has_many :projects, :foreign_key => "user_id"
  has_many :team_memberships, :class_name => 'TeamMember'
  has_many :team_projects, :through => :team_memberships, :source => :project

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
end
