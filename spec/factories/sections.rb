FactoryGirl.define do
  factory :section do
    book
    name Faker::Lorem.word
		content Faker::Lorem.paragraph
  end
end
