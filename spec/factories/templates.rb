FactoryGirl.define do
  factory :template do
    user
		content Faker::Lorem.paragraph
		name Faker::Lorem.word
  end
end
