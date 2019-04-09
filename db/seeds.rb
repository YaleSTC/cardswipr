# frozen_string_literal: true

# seed the database with a few users, events, and attendances
puts 'Please enter your NetID'
net_id = $stdin.gets.chomp

cur_user = FactoryBot.create(:user_with_events, username: net_id)
user2 = FactoryBot.create(:user_with_events)
user3 = FactoryBot.create(:user_with_events)

cur_user.events.each do |event|
  2.times do
    FactoryBot.create(:attendance, event: event)
  end
end
