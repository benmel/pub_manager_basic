FactoryGirl.define do
  factory :filled_liquid_template_parameter do
    filled_liquid_template
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
