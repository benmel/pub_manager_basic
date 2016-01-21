FactoryGirl.define do
  factory :description_parameter do
    description
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
