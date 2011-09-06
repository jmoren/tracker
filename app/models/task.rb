class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_list
  belongs_to :user
  STATUS=['created','progress','commited','testing','aproved','merged']
  PRIORITY=['high','medium','normal','low']
  attr_accessible :task_list_id, :project_id, :description, :status, :user_id, :priority

  scope :by_status, lambda{|status, tl| where(:status => status, :task_list_id => tl.id)}
  def update_status(status)
    self.update_attributes(:status => status)
    return self.status
  end
end

