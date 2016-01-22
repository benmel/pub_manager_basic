FactoryGirl.define do
  factory :toc_section do
    book
		content Faker::Lorem.paragraph
  end
end
