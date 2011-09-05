require 'test_helper'

class BugsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Bug.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Bug.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Bug.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to bug_url(assigns(:bug))
  end

  def test_edit
    get :edit, :id => Bug.first
    assert_template 'edit'
  end

  def test_update_invalid
    Bug.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Bug.first
    assert_template 'edit'
  end

  def test_update_valid
    Bug.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Bug.first
    assert_redirected_to bug_url(assigns(:bug))
  end

  def test_destroy
    bug = Bug.first
    delete :destroy, :id => bug
    assert_redirected_to bugs_url
    assert !Bug.exists?(bug.id)
  end
end
