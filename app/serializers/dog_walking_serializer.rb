class DogWalkingSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :price, :duration, :latitude, :longitude,
  :start, :finish, :status
end