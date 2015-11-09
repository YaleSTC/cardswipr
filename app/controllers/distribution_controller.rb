require 'yale_id_lookup'

class DistributionController < ApplicationController

  def home
    authorize! :read, :homepage
  end

  def personlookup
    authorize! :read, :personlookup
    if params[:query]
      person = YaleIDLookup.lookup(params[:query])
      return unless person

      @upi = person.upi
      @netid = person.netid
      sys_id = ServiceNow::User.find(@netid).sys_id

      first_name = person.known_as || person.first_name || ''
      @name = "#{first_name} #{person.last_name || ''}"
      @email = person.email || ''
      @phone = person.phone || ''

      @sn_destination_url = 'https://yale.service-now.com/incident.do?' \
        "sys_id=-1&sysparm_query=caller_id=#{sys_id}" \
        "^u_contact=#{sys_id}^u_client=#{sys_id}"
    end
  end
end
