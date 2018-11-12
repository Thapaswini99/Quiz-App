class Leaderboard < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :subgenre
  belongs_to :score
end
