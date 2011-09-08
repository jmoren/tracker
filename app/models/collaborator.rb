class Collaborator < ActiveRecord::Base
 
 belongs_to :user
 belongs_to :project

 ROLE=['admin','collaborator']

 def update_field(field,option)
   self.update_attributes(field.to_sym => option)
 end
end
