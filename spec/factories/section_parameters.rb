FactoryGirl.define do
  factory :section_parameter do
    section
    front_section
    toc_section
		name Faker::Lorem.word
		value Faker::Lorem.word
  end
end
