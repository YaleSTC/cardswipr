class Role < ActiveRecord::Base

  establish_connection "oracle"
  self.table_name = "people.ppl_roles_s"

  scope :upi,             ->(upi)   { where(yale_upi: upi) }
  scope :in_class_year,   ->(year)  { where(class_year: year.to_s) }
  scope :undergrad,       ->        { where(role: 'UNDERGRADUATE') }
  scope :grad,            ->        { where(role: 'GRAD_STUDENT') }

  def class_year
    read_attribute(:class_year).to_i
  end
end
