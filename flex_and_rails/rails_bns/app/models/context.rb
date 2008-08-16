# == Schema Information
# Schema version: 2
#
# Table name: contexts
#
#  id         :integer         not null, primary key
#  label      :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#

class Context < ActiveRecord::Base
  
  has_many :tasks
  
  acts_as_nested_set
  
  validates_presence_of :label
  
end
