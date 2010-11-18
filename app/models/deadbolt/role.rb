class Deadbolt::Role < ActiveRecord::Base

  has_many :role_assignments, :dependent => :destroy
  has_many :users, :through => :role_assignments
  has_many :role_permissions, :dependent => :destroy
  accepts_nested_attributes_for :role_permissions, :allow_destroy => true
  has_many :permissions, :through => :role_permissions

  validates :name, :presence => true
  validates_uniqueness_of :name, :case_sensitive => false

  before_validation { clean_text_attributes :name }

  default_scope :order => :name
end
