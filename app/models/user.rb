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
end
