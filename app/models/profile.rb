class Profile < ActiveRecord::Base
  belongs_to :user, :inverse_of => :profile

  validates :username,
    :uniqueness => true,
    :presence => true,
    :length => { maximum: 16, too_long: "can only be %{count} characters long" },
    :on => :create
  validate :username_unchanged, :on => :update

  private

  def username_unchanged
    errors[:username] = "cannot be modified!" if self.username_changed?
  end
end
