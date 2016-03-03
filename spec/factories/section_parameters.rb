FactoryGirl.define do
  factory :section_parameter do
    body_section
    toc_section
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
