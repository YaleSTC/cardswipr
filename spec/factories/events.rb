# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title 'Event 1'
    description 'please swipe your card'
    before :create do |obj|
      obj.users << create(:user)
    end
  end
end
