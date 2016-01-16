FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
	  
	  factory :user_with_projects do
			transient do
	      projects_count 5
	    end

	    after(:create) do |user, evaluator|
	      create_list(:project, evaluator.projects_count, user: user)
	    end
		end
  end
end
