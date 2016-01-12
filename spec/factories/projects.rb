FactoryGirl.define do
	factory :project do
		user
		title Faker::Book.title
		subtitle Faker::Book.title
		author Faker::Book.author
		keywords Faker::Lorem.words.join(',')
		isbn10 Faker::Number.number(10)
		isbn13 Faker::Number.number(13)
	end
end