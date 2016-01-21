FactoryGirl.define do
  factory :template_parameter do
    template
		name Faker::Lorem.word
  end
end
