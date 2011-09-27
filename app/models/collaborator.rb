class Collaborator < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  has_many :activities, :as => :target, :dependent => :destroy
  ROLE=['admin','collaborator']

  def update_field(field,option)
    self.update_attributes(field.to_sym => option)
  end

  def new_activity(project, user, action)
    a = self.activities.new(:project_id => project, :user_id => user, :action => action)
    a.save
    a.notify!
  end

end

