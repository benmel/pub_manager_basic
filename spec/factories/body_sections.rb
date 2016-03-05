FactoryGirl.define do
  factory :body_section do
    book nil
    name Faker::Lorem.word
		content Faker::Lorem.paragraph
  end
end
