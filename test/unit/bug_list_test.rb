require 'test_helper'

class BugListTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert BugList.new.valid?
  end
end
