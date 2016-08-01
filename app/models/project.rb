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

end
