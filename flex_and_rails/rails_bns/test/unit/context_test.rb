require File.dirname(__FILE__) + '/../test_helper'

class ContextTest < ActiveSupport::TestCase  

  def test_context_without_label_fails
    non_label_context = Context.new
    assert !(non_label_context.save)
    error_messages = non_label_context.errors.on(:label)
    assert !(error_messages.empty?)
  end

  def test_context_with_label_saves
    context = Context.new
    context.label = "Anarcho-syndicalist Commune Bi-weekly Meetings"
    assert context.save
    error_messages = context.errors.on(:label)
    assert_nil error_messages
  end

end
