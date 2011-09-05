require 'test_helper'

class TaskListTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TaskList.new.valid?
  end
end
