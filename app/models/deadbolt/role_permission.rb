class Deadbolt::RolePermission < ActiveRecord::Base

  belongs_to :role
  belongs_to :permission

  validates :role, :permission, :presence => true
  validates_associated :role, :permission
end
