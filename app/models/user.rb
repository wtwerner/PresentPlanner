class User < ActiveRecord::Base
    has_secure_password
    has_many :recipients
    has_many :lists, through: :recipients
end