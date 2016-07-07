class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

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
