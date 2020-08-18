class Gift < ActiveRecord::Base
    belongs_to :list
    belongs_to :recipient
end