class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :target, :polymorphic => true
  has_many :notifications, :dependent => :destroy
  
  def notify!
    project = self.project
    collaborators = project.collaborators
    self.notifications.create(:user_id => self.project.user.id, :readed => false)
    collaborators.each do |collaborator|
      self.notifications.create(:user_id => collaborator.user.id, :readed => false)
    end
  end

end
