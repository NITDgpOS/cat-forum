FactoryGirl.define do
  factory :reply do
    content 'newthread'
    association :user
    association :new_thread
  end
end
