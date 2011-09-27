class TaskList < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  belongs_to :project
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  has_many :activities, :as => :target, :dependent => :destroy
  attr_accessible :project_id, :title, :comments, :status, :user_id, :end_date

  STATUS=['open','closed','reopened']

  def new_activity(project, user, action)
    a = self.activities.new(:project_id => project, :user_id => user, :action => action)
    a.save
  end
end

