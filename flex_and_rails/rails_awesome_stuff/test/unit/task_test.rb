require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup
    @context = contexts :work 
  end

  def test_require_context
    t = Task.new :label => "New Task"
    assert_equal false, t.save
    t.context = @context
    assert t.save
  end

end
