class List < ActiveRecord::Base
    belongs_to :recipient
    has_many :gifts
end