require "yaleidlookup"

class DistributionController < ApplicationController

  def home
    authorize! :read, :homepage
  end

  def personlookup
    authorize! :read, :personlookup
    if params[:query]
      attributes = YaleIDLookup.lookup(params[:query])

      sys_id = ServiceNow::User.find(attributes.netid).sys_id
      
      @name = attributes[:first_name] + attributes[:last_name]
      # @email = person.email
      # @affiliation = "Undergraduate"
      @sn_destination_url = "https://yale.service-now.com/incident.do?sys_id=-1&sysparm_query=caller_id=" + sys_id + "^u_contact=" + sys_id
      @phonebook_destination_url = "http://directory.yale.edu/phonebook/index.htm?searchString=upi%3D" + upi
    end
  end

end
