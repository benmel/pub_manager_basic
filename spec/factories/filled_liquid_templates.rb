FactoryGirl.define do
  factory :filled_liquid_template do
		filled_liquid_templatable nil
    content Faker::Lorem.paragraph

    trait :valid_content do
			content 'Hello {{ name }}'
		end

		trait :invalid_content do
			content 'Hello {{ name'
		end

		trait :marketplace_content do
			content "{% if marketplace == 'kindle' %}kindle content{% elsif marketplace == 'createspace' %}createspace content{% elsif marketplace == 'acx' %}acx content{% endif %}"
		end

		factory :filled_liquid_template_with_parameters do
			transient do
				filled_liquid_template_parameters_count 5
			end

			after(:create) do |filled_liquid_template, evaluator|
				create_list(:filled_liquid_template_parameter, evaluator.filled_liquid_template_parameters_count, filled_liquid_template: filled_liquid_template)
			end
		end
  end
end
