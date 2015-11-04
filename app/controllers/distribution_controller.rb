require 'yale_id_lookup'

class DistributionController < ApplicationController

  def home
    authorize! :read, :homepage
  end

  def personlookup
    authorize! :read, :personlookup
    if params[:query]
      attributes = YaleIDLookup.lookup(params[:query])
      return unless attributes
      
      upi = attributes[:upi]
      #sys_id = ServiceNow::User.find(attributes[:netid]).sys_id

      @name = attributes[:first_name] + " " + attributes[:last_name]
      @email = attributes[:email]
      @affiliation = attributes[:school] + " " + attributes[:college_abbreviation] + " " + attributes[:class_year]
      # @affiliation = "Unknown Affiliation" if @affiliation.blank?
      @curriculum = attributes[:major]
      # @curriculum = "No Curriculum/Major" if @curriculum.blank?
      @organization = attributes[:organization]
      # @organization = "No Organization" if @organization.blank?

      #@sn_destination_url = "https://yale.service-now.com/incident.do?sys_id=-1&sysparm_query=caller_id=" + sys_id + "^u_contact=" + sys_id
      @sn_destination_url = "https://yale.service-now.com/incident.do"

      @phonebook_destination_url = "http://directory.yale.edu/?queryType=field&upi=" + upi
    end
  end

end
