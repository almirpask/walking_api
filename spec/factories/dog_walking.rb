FactoryBot.define do
  factory :dog_walking do
    duration { [30, 60].sample }
    latitude { -23.476104 }
    longitude { -46.641790 }
    pets { rand(1..4) }
    scheduled_day { DateTime.now + rand(0..5) }

    factory :dog_walking_duration_60 do
      duration { 60 }
    end

    factory :dog_walking_duration_30 do
      duration { 30 }
    end
  end
end