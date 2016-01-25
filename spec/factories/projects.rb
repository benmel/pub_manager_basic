FactoryGirl.define do
	factory :project do
		user
		title Faker::Book.title
		subtitle Faker::Book.title
		author Faker::Book.author
		keywords Faker::Lorem.words.join(',')
		isbn10 Faker::Number.number(10)
		isbn13 Faker::Number.number(13)

		factory :project_with_book do
	    after(:create) do |project, evaluator|
	      create(:book, project: project)
	    end
		end
	end
end