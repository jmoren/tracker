require 'test_helper'

class TaskListsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => TaskList.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    TaskList.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    TaskList.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to task_list_url(assigns(:task_list))
  end

  def test_edit
    get :edit, :id => TaskList.first
    assert_template 'edit'
  end

  def test_update_invalid
    TaskList.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TaskList.first
    assert_template 'edit'
  end

  def test_update_valid
    TaskList.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TaskList.first
    assert_redirected_to task_list_url(assigns(:task_list))
  end

  def test_destroy
    task_list = TaskList.first
    delete :destroy, :id => task_list
    assert_redirected_to task_lists_url
    assert !TaskList.exists?(task_list.id)
  end
end
