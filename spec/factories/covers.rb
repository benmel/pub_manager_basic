FactoryGirl.define do
	factory :cover do
		project
		photographer { Faker::Name.name }
		license { "CC BY-SA 4.0" }
	end
end