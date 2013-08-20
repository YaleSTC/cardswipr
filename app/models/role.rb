class Role < ActiveRecord::Base

  establish_connection "oracle"
  self.table_name = "people.ppl_roles_s"

  scope :upi,      ->(upi)   { where(yale_upi: upi) }
  scope :class_year,  ->(year)  { where(class_year: year.to_s) }
  scope :undergrad,   ->        { where(role: 'UNDERGRADUATE') }
end
