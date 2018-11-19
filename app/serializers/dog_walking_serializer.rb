class DogWalkingSerializer < ActiveModel::Serializer
  attributes :id, :total_time, :start, :finish #, :price, :duration, :latitude, :longitude, :start, :finish, :created_at

  def total_time
    ((object.finish - object.start) / 1.hours)
  end
end
