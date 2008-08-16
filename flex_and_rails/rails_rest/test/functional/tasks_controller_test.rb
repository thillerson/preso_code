require File.dirname(__FILE__) + '/../test_helper'

class TasksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_task
    assert_difference('Task.count') do
      post :create, :task => { :label => 'do stuff', :context => contexts(:home) }
    end

    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_show_task
    get :show, :id => tasks(:finish_flex_maniacs_preso).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tasks(:finish_flex_maniacs_preso).id
    assert_response :success
  end

  def test_should_update_task
    put :update, :id => tasks(:finish_flex_maniacs_preso).id, :task => { }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_destroy_task
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:finish_flex_maniacs_preso).id
    end

    assert_redirected_to tasks_path
  end
end
