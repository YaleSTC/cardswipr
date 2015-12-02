# An abstraction of attributes for a person
class Person
  attr_accessor :upi
  attr_accessor :netid
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :known_as
  attr_accessor :email
  attr_accessor :phone

  def update_from_cardswipr_api(rec)
    @upi = rec['Upi']
    @netid = rec['NetId']
    @first_name = rec['FirstName']
    @last_name = rec['LastName']
    @known_as = rec['KnownAs']
    @email = rec['EmailAddress']
    @phone = rec['WorkPhone']
    self
  end

  # Return attributes according to the db schema
  def attributes
    {
      upi: @upi,
      netid: @netid,
      first_name: @first_name,
      last_name: @last_name,
      nickname: @known_as,
      email: @email,
      telephone: @phone
    }
  end

  def to_s
    "#{@first_name} (#{@known_as}) #{@last_name}, #{@email}, #{@phone}, #{@netid}, #{@upi}"
  end
end
