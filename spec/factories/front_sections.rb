FactoryGirl.define do
  factory :front_section do
    book
		content Faker::Lorem.paragraph
  end
end
