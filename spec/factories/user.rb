FactoryGirl.define do
  sequence :username do |n|
    "cat_ninza#{n}"
  end

  sequence :email do |n|
    "cat_ninza#{n}@gmail.com"
  end

  factory :user do
    email
    username
    password 'secret12345'

    after(:create) do |user|
      user.confirm
    end
  end
end
