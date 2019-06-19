# frozen_string_literal: true

class FakeApi
  cattr_accessor :base_url
  self.base_url = ENV.fetch("FAKE_API_BASE_URL")

  def successful_match_for(user:)
    HTTParty.get(self.base_url + "users/#{user.id}", format: json)
  end
end
