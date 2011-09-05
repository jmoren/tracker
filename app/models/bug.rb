class Bug < ActiveRecord::Base
  attr_accessible :bug_list_id, :project_id, :description, :status, :user_id, :owner
end
