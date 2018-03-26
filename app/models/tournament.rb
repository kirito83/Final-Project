class Tournament < ApplicationRecord
	has_and_belongs_to_many :participants, class_name: 'User'
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	belongs_to :category, class_name: 'Category', foreign_key: 'category_id'
	has_many :matches, class_name: 'Match'

	validates :pricepool, presence: true
	validates :maxPlayers, presence: true
	validates :title, presence: true
end
