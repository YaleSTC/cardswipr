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

  def roles
    Role.upi(self.yale_upi)
  end

  def undergrad?
    roles.undergrad.any?
  end

  def grad_student?
    roles.grad.any?
  end

  def student_roles
    [roles.undergrad, roles.grad].flatten
  end

  def allowed_year?
    allowed_years = Setting.allowed_years

    # if no year is set, all years are good
    if allowed_years.blank?
      return true
    end

    student_roles.each do |role|
      return true if allowed_years.include?(role.class_year)
    end
    return false
  end

  def given_key?
    return Student.find_by(netid: self.netid).present?
  end

  def give_key
    return false if given_key?
    Student.create(self.student_attrs)
  end

  def student_attrs
    attrs = ["first_name", "last_name", "netid", "yale_upi", "id_card_number"]
    self.attributes.select{|k,v| attrs.include? k}
  end

end
