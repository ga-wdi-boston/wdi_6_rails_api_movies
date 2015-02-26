class Movie < ActiveRecord::Base

  RATINGS = %w{ g pg pg-13 r nc-17 }

  has_many :reviews, dependent: :destroy

end
