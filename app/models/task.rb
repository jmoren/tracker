class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_list
  belongs_to :user
  has_many :comments, :dependent => :destroy

  STATUS=['pending','working','stacked','aproved','abandoned']
  PRIORITY=['high','medium','low','unknown']
  attr_accessible :task_list_id, :project_id, :description, :status, :user_id, :priority,:state

  scope :by_state, lambda{|state, tl| where(:state => state, :task_list_id => tl.id)}
  def update_status(option)
    self.update_attributes(:status => option)
  end  
  def update_state(state)
    self.update_attributes(:state => state)
  end
end

