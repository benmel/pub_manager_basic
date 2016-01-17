FactoryGirl.define do
  factory :section do
    book
		content Faker::Lorem.paragraph
  end
end
