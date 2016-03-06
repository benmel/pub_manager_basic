FactoryGirl.define do
  factory :liquid_template do
    user
		content Faker::Lorem.paragraph
		name Faker::Lorem.word
		category { [:other, :description, :front_section, :toc_section, :body_section].sample }

		trait :valid_content do
			content 'Hello {{ name }}'
		end

		trait :invalid_content do
			content 'Hello {{ name'
		end
  end
end
