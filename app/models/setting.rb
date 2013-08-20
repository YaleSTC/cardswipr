class Setting < ActiveRecord::Base

  def self.create_default
    self.create(freshman_year = Date.today.year + 4)
  end

  # This lets us do Setting.freshman_year instead of
  # Setting.first.freshman_year, etc.
  SETTINGS = [:freshman_year]
  SETTINGS.each do |setting|
    define_singleton_method setting do
      self.first.send(setting)
    end
  end

end