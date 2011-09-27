class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :target, :polymorphic => true
  has_many :notifications, :dependent => :destroy
  
  def notify!
    project = self.project
    users = project.collaborators
    self.notifications.create(:user_id => self.project.user.id)
    users.each do |user|
      self.notifications.create(:user_id => user.id)
    end
  end

end
