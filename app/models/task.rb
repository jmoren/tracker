class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_list
  belongs_to :user
  belongs_to :assigned, :class_name => 'User', :foreign_key => :assigned_id
  has_many :comments, :dependent => :destroy
  has_many :activities, :as => :target, :dependent => :destroy
  STATUS=['created','pending','working','locked','aproved','abandoned']
  PRIORITY=['high','medium','low','unknown']
  attr_accessible :task_list_id, :project_id, :description, :status, :user_id, :priority,:state, :assigned_id

  scope :by_state, lambda{|state, tl| where(:state => state, :task_list_id => tl.id)}

  def update_state(state)
    self.update_attributes(:state => state)
  end
  def update_field(field, value)
    if field == 'assigned'
      field = 'assigned_id'
      value = value.id
    end
    self.update_attributes(field.to_sym => value)
  end

  def new_activity(project, user, action)
    a = self.activities.new(:project_id => project, :user_id => user, :action => action)
    a.save
    a.notify!
  end
end

