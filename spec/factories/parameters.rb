FactoryGirl.define do
  factory :parameter do
    template
		name Faker::Lorem.word
  end
end
