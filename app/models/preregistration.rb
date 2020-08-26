# frozen_string_literal: true

class Preregistration < CheckIn
  def checked_in
    !checked_in_at.nil?
  end
end
