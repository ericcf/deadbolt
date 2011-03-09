class Deadbolt::User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids

  has_many :role_assignments, :dependent => :destroy
  has_many :roles, :through => :role_assignments

  default_scope :order => :email

  def self.update_each_admin(users_admin_attributes)
    stringified_attributes = users_admin_attributes.stringify_keys
    all.each do |user|
      unless (user_attributes = stringified_attributes[user.id.to_s]).nil?
        is_admin = [true, "true", 1, "1"].include?(user_attributes[:admin])
        user.update_attribute(:admin, is_admin)
      else
        user.update_attribute(:admin, false)
      end
    end
  end
end
