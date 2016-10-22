FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :admin do    
    password "test1234"
    email
    
    trait :sys_admin do
      system_admin true
    end
  end
end
