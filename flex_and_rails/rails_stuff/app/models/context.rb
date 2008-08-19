# == Schema Information
# Schema version: 20080817071858
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
  
  validates_presence_of :label
  
end
