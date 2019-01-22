class User < ActiveRecord::Base
  has_many :actions
  has_secure_password
end
