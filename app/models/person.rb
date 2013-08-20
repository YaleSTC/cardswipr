class Person < ActiveRecord::Base

  establish_connection "oracle"
  self.table_name = "people.ppl_identity_v"

  def self.search(query)
    if id_number = query.match(/\d{10}/)
      return Person.find_by(id_card_number: id_number[0])
    else
      return Person.find_by(netid: query)
    end
  end

  def name
    first_name + " " + last_name
  end

  def undergrad?
    Role.upi(self.yale_upi).undergrad.any?
  end

  def freshman?
    freshman_year = Setting.freshman_year
    Role.upi(self.yale_upi).undergrad.class_year(freshman_year).any?
  end

  def given_key?
    return Student.find_by(netid: self.netid).present?
  end

  def give_key
    return false if given_key?
    Student.create(self.student_attrs)
  end

  private
  def student_attrs
    attrs = ["first_name", "last_name", "netid", "yale_upi", "id_card_number"]
    self.attributes.select{|k,v| attrs.include? k}
  end

end
