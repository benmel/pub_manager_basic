FactoryGirl.define do
	factory :project do
		title { Faker::Book.title }
		subtitle { Faker::Book.title }
		author { Faker::Book.author }
		keywords { Faker::Lorem.words.join(',') }
		description { Faker::Lorem.paragraph }
		isbn10 { Faker::Number.number(10) }
		isbn13 { Faker::Number.number(13) }
	end
end