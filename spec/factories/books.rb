FactoryGirl.define do
  factory :book do
    project
		content Faker::Lorem.paragraph
  end
end
