# == Schema Information
# Schema version: 20080817071858
#
# Table name: tasks
#
#  id         :integer         not null, primary key
#  label      :string(255)     
#  context_id :integer         
#  created_at :datetime        
#  updated_at :datetime        
#

class Task < ActiveRecord::Base
  
  belongs_to :context
  
  validates_presence_of :context, :label
  
end
