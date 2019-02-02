class Action < ActiveRecord::Base
  belongs_to :user

  validates :action_name, :presence => true
  validates :status, :presence => true
end
