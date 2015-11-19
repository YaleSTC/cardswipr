# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    netid 'willy'
    first_name 'Willy'
    last_name 'Wonka'
  end
end
