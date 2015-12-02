require 'spec_helper'

describe 'User', type: :feature do
  before :each do
    @user = create(:user) # creating willy
    sign_in(@user.netid)
  end

  it 'shows user when signed in' do
    visit '/'
    expect(page).to have_content 'Willy Wonka'
  end
end
