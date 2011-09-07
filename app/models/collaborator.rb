class Collaborator < ActiveRecord::Base
 
 belongs_to :user
 belongs_to :project

 ROLE=['admin','collaborator']

end
