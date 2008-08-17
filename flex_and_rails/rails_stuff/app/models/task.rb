class Task < ActiveRecord::Base
  
  belongs_to :context
  
  validates_presence_of :context, :label
  
end
