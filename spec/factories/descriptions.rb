FactoryGirl.define do
	factory :description do
		project
		content Faker::Lorem.paragraph
		chapter_list Faker::Lorem.words.join(';')
		excerpt Faker::Lorem.paragraph

		factory :description_with_valid_template do
			after(:create) do |description, evaluator|
				description.filled_liquid_template = create(:filled_liquid_template, :valid_content)
			end
		end

		factory :description_with_invalid_template do
			after(:create) do |description, evaluator|
				description.filled_liquid_template = create(:filled_liquid_template, :invalid_content)
			end
		end

		factory :description_with_marketplace_template do
			after(:create) do |description, evaluator|
				description.filled_liquid_template = create(:filled_liquid_template, :marketplace_content)
			end
		end

		factory :description_with_parameters do
			after(:create) do |description, evaluator|
				description.filled_liquid_template = create(:filled_liquid_template_with_parameters)
			end
		end
	end
end
