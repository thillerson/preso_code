class Context < ActiveRecord::Base
  
  has_many :tasks
  
  validates_presence_of :label
  
end
