FactoryGirl.define do
  factory :new_thread do
    title 'test title'
    description 'test descriptions can be boring'
    association :user
  end
end