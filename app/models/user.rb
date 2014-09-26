class User < ActiveRecord::Base
  has_and_belongs_to_many :event

  def name
    first_name + " " + last_name
  end
end
