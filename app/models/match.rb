class Match < ApplicationRecord
	belongs_to :tournament, foreign_key: 'tournament_id'
end
