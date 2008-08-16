# == Schema Information
# Schema version: 2
#
# Table name: tasks
#
#  id           :integer         not null, primary key
#  label        :string(255)     
#  context_id   :integer         
#  completed_at :datetime        
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Task < ActiveRecord::Base
  
  belongs_to :context
  
  validates_presence_of :label
  validates_presence_of :context
  
end
