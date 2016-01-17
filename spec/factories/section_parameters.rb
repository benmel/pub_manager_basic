FactoryGirl.define do
  factory :section_parameter do
    section
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
