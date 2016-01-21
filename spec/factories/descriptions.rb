FactoryGirl.define do
  factory :description do
    project
		template Faker::Lorem.paragraph
		content Faker::Lorem.paragraph
		chapter_list Faker::Lorem.words.join(';')
		excerpt Faker::Lorem.paragraph

		trait :valid_template do
			template 'Hello {{ name }}'
		end

		trait :invalid_template do
			template 'Hello {{ name'
		end

		trait :marketplace_template do
			template "{% if marketplace == 'kindle' %}kindle content{% elsif marketplace == 'createspace' %}createspace content{% elsif marketplace == 'acx' %}acx content{% endif %}"
		end

		factory :description_with_description_parameters do
			transient do
        description_parameters_count 5
      end

      after(:create) do |description, evaluator|
        create_list(:description_parameter, evaluator.description_parameters_count, description: description)
      end
		end
  end
end
