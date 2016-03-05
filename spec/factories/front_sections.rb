FactoryGirl.define do
  factory :front_section do
    book nil
		content Faker::Lorem.paragraph
  end
end
