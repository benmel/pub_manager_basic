FactoryGirl.define do
  factory :liquid_template do
    user
		content Faker::Lorem.paragraph
		name Faker::Lorem.word
		template_type Faker::Number.between(0, 4)

		trait :valid_content do
			content 'Hello {{ name }}'
		end

		trait :invalid_content do
			content 'Hello {{ name'
		end
  end
end
