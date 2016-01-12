FactoryGirl.define do
  factory :filled_parameter do
    description
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
