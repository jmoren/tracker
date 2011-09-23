class TaskList < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  belongs_to :project 
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  attr_accessible :project_id, :title, :comments, :status, :user_id, :end_date

  STATUS=['open','closed','reopened']
end
