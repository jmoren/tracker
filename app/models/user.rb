class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  has_friendly_id :username, :use_slug => true
  has_many :collaborators, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :task_lists, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :assigments, :class_name => 'Task'
  has_many :activities, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end
  def my_projects
    projects = []
    projects << Project.where(:user_id => self.id)
    col = self.collaborators.where(:user_id => self.id)
    col.each do |c|
      projects << c.project
    end
    return projects.flatten!
  end
  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  def as_member(project)
    self.collaborators.where(:project_id => project.id).first
  end
  def is_admin_or_owner?(project)
    project.user == self || project.collaborators.where(:role => 'admin').collect(&:user).include?(self)
  end
  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end

