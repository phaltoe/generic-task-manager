class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, :dependent => :destroy

  validates_associated :profile, :on => :create

  delegate :username, :to => :profile
  delegate :website, :to => :profile

  default_scope { where(:active => true) }
  accepts_nested_attributes_for :profile

  def active?
    active
  end
end
