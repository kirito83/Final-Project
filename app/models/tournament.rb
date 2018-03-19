class Tournament < ApplicationRecord
	belongs_to :creator, class_name: 'User', foreign_key: 'user.id'
	has_and_belongs_to_many :participants, class_name: 'User'
end
