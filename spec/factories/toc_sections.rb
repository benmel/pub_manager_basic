FactoryGirl.define do
  factory :toc_section do
    book nil
		content Faker::Lorem.paragraph
  end
end
