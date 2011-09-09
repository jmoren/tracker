class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_list
  belongs_to :user
  has_many :comments, :dependent => :destroy

  STATUS=['todo','progress','commited','testing','aproved','done']
  PRIORITY=['high','medium','normal','low']
  attr_accessible :task_list_id, :project_id, :description, :status, :user_id, :priority,:state

  scope :by_state, lambda{|state, tl| where(:state => state, :task_list_id => tl.id)}
  
  def update_state(state)
    self.update_attributes(:state => state)
  end
end

