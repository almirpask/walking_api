FactoryBot.define do
  factory :dog_walking do
    duration { [30, 60].sample }
    latitude { -23.476104 }
    longitude { -46.641790 }
    pets { [1, 2, 3].sample }
  end
end