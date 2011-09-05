require 'test_helper'

class BugTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Bug.new.valid?
  end
end
