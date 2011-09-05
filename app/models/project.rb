class Project < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  has_many :task_lists
  has_many :bug_lists
  attr_accessible :name, :description, :start_date, :end_date, :status, :user_id

  validate :name, :description, :status, :presence => true
  validate :name, :uniqueness => true

  validate :dates, :if => Proc.new {|p| !p.start_date.blank? || !p.end_date.blank? }


private 
  def dates
    if (self.start_date && self.end_date.blank?) || (self.end_date && self.start_date.blank?)
      #error
    else
      #validamos start-end
    end
  end
end
