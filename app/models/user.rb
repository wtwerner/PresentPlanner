class User < ActiveRecord::Base
    has_many :recipients
    has_many :lists, through: :recipients
end