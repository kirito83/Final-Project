class Tournament < ApplicationRecord
	has_and_belongs_to_many :participants, class_name: 'User'
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	has_many :matches, class_name: 'Match'
end
