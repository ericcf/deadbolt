class Deadbolt::RoleAssignment < ActiveRecord::Base

  belongs_to :user
  belongs_to :role

  validates :user, :role, :presence => true
  validates_associated :user, :role
  validates_uniqueness_of :role_id, :scope => :user_id
end
