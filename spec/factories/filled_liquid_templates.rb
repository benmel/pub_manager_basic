FactoryGirl.define do
  factory :filled_liquid_template do
		filled_liquid_templatable nil
    content Faker::Lorem.paragraph
  end
end
