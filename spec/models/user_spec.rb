require 'spec_helper'

RSpec.describe User, type: :model do
  it '#get_user_attributes' do
    user = User.create(netid: 'willy', last_name: '')
    user.get_user_attributes
    expect(user.netid).to eq('willy')
    expect(user.first_name).to eq('Willy')
    expect(user.last_name).to eq('Wonka')
    expect(user.email).to eq('willy@example.com')
  end

  it '#full_name' do
    user1 = User.create(netid: 'willy', last_name: '')
    expect(user1.full_name).to eq('Willy Wonka')
    user2 = User.create(netid: 'frodo')
    expect(user2.full_name).to eq('Frodo Baggins')
  end

  it '#full_name_with_netid' do
    user = User.create(netid: 'willy', last_name: '')
    expect(user.full_name_with_netid).to eq('Willy Wonka willy')
  end
end
