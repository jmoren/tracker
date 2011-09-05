class TaskList < ActiveRecord::Base
  belongs_to :project 
  has_many :tasks, :dependent => :destroy
  attr_accessible :project_id, :title
end
