require File.dirname(__FILE__) + '/../test_helper'

class TaskTest < ActiveSupport::TestCase
  
  def setup
    @ascbwm_context = contexts(:anarco_syndicalist_commune_biweekly_meetings)
  end
  
  def test_task_without_label_fails
    non_label_task = @ascbwm_context.tasks.build
    assert !(non_label_task.save)
    error_messages = non_label_task.errors.on(:label)
    assert !(error_messages.empty?)
  end

  def test_task_with_label_saves
    task = @ascbwm_context.tasks.build
    task.label = "Collect lovely filth"
    assert task.save
    error_messages = task.errors.on(:label)
    assert_nil error_messages
  end
  
  def test_task_must_have_context
    task = Task.new(:label => "Find out who lives in that castle")
    assert !(task.save)
    error_messages = task.errors.on(:context)
    assert_not_nil error_messages
    task.context = @ascbwm_context
    assert task.save
  end

end
