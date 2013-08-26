class Setting < ActiveRecord::Base

  def self.create_default
    self.create(allowed_years: (Date.today.year + 4).to_s)
  end

  # This lets us do Setting.freshman_year instead of
  # Setting.first.freshman_year, etc.
  SETTINGS = [:allowed_years]
  SETTINGS.each do |setting|
    define_singleton_method setting do
      self.first.send(setting)
    end
  end

  def allowed_years
    read_attribute(:allowed_years).split(",").map(&:to_i)
  end

end