class TaskList < ActiveRecord::Base
  belongs_to :project 
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  attr_accessible :project_id, :title, :comments, :status, :user_id

  STATUS=['open','closed','reopened']
end
