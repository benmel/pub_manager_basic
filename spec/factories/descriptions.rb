FactoryGirl.define do
  factory :description do
    project
		template Faker::Lorem.paragraph
		content Faker::Lorem.paragraph
		chapter_list Faker::Lorem.words.join(',')
		excerpt Faker::Lorem.paragraph
  end
end
