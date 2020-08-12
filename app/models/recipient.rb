class Recipient < ActiveRecord::Base
    belongs_to :user
    has_many :lists
    has_many :gifts, through: :lists
end