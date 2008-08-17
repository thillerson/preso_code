require 'test_helper'

class ContextTest < ActiveSupport::TestCase

  def test_require_label
    c = Context.new
    assert_equal false, c.save
    c.label = "New Context"
    assert c.save
  end

end
