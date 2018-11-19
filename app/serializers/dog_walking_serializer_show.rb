class DogWalkingSerializerShow < ActiveModel::Serializer
  attributes :id, :total_time

  def total_time
    unless object.start.nil?
      (((object.finish || Time.now) - object.start) / 1.hours).round(2)
    else
      0
    end
  end
end