class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :stars, :comment
end
