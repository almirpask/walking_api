class DogWalkingSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :price, :duration, :latitude, :longitude, :start, :finish, :created_at
end