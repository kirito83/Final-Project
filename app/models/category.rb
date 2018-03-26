class Category < ApplicationRecord
	has_many :tournaments, class_name: 'Tournament'
end
