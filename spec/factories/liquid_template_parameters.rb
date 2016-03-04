FactoryGirl.define do
  factory :liquid_template_parameter do
    liquid_template
		name Faker::Lorem.word
  end
end
