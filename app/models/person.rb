class Person < ActiveRecord::Base

  establish_connection "oracle"
  self.table_name = "people.ppl_identity_v"

  def self.search(query)
    if config.stubbed_mode
      person = Person.new({"people_id"=>151717, "people_start_dt"=>Time.parse("Mon, 28 Jul 2014 00:00:00 UTC +00:00"), "people_end_dt"=>Time.parse("Tue, 31 Dec 4712 00:00:00 UTC +00:00"), "identity_studentrole_change_dt"=>Time.parse("Mon, 28 Jul 2014 00:00:00 UTC +00:00"), "old_people_id"=>nil, "title"=>"Ms.", "last_name"=>"Corona", "first_name"=>"Adriana", "middle_name"=>nil, "suffix"=>nil, "birth_date"=>Time.parse("Sun, 11 Nov 1984 00:00:00 UTC +00:00"), "sex"=>"F", "work_phone"=>"203-436-9681", "netid"=>"amc95", "email_alias"=>"adriana.corona@yale.edu", "id_card_number"=>0005454661, "banner_id"=>896898, "person_type"=>"Employee and Alumnus", "student_flag"=>"N", "test"=>Time.parse("Tue, 05 Aug 2014 01:00:29 UTC +00:00"), "yale_upi"=>11725806, "benefactor_id"=>nil})
      return person
    else
      if id_number = query.match(/\d{10}/)
        return Person.find_by(id_card_number: id_number[0])
      else
        return Person.find_by(netid: query)
      end
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
