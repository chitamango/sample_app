FactoryGirl.define do
  factory :user do
   # name     "Michael Hartl"
   # email    "michael@example.com"
   # password "foobar"
   # password_confirmation "foobar"

   	sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    #add a factory for admin user
    factory :admin do
      admin true
    end

  end
end