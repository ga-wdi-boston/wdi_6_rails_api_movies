class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :total_gross, :description, :released_on
  has_many :reviews
end
