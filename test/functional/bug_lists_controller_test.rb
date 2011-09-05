require 'test_helper'

class BugListsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => BugList.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    BugList.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    BugList.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to bug_list_url(assigns(:bug_list))
  end

  def test_edit
    get :edit, :id => BugList.first
    assert_template 'edit'
  end

  def test_update_invalid
    BugList.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BugList.first
    assert_template 'edit'
  end

  def test_update_valid
    BugList.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BugList.first
    assert_redirected_to bug_list_url(assigns(:bug_list))
  end

  def test_destroy
    bug_list = BugList.first
    delete :destroy, :id => bug_list
    assert_redirected_to bug_lists_url
    assert !BugList.exists?(bug_list.id)
  end
end
