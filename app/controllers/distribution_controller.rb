class DistributionController < ApplicationController

  def home
    authorize! :read, :homepage
  end

  def index
    authorize! :read, :cardswipe
    @count = Student.count
  end

  def lookup
    authorize! :lookup, :cardswipe
    upi = Person.lookup(params[:query])
    person = Person.new(upi: upi)

    if person.nil?
      flash.now[:error] = "I'm sorry, Dave, I didn't find anyone"
      redirect_to :distribution_index
    end

    if person.recorded?
      flash[:error] = "#{person.name} has already been recorded for this event."
      redirect_to :distribution_index and return
    end

    if person.record
      flash[:notice] = "#{person.name} has been successfully recorded for this event."
      @count = Student.count
    else
      flash[:error] = "Unexpected error while trying to record this person."
    end

    redirect_to :distribution_index

  end

  # def phonebook
  #   authorize! :read, :phonebook
  # end

  # def phonebooklookup
  #   authorize! :lookup, :phonebook
  #   upi = Person.lookup(params[:query])
  #   @phonebook_destination_url = "http://directory.yale.edu/phonebook/index.htm?searchString=upi%3D" + upi
  #   redirect_to @phonebook_destination_url
  # end

  def personlookup
    authorize! :read, :personlookup
    if params[:query]
      upi = Person.lookup(params[:query])
      person = Person.new(upi: upi)

      ServiceNow::Configuration.configure(:sn_url => ENV['SN_INSTANCE'], :sn_username => ENV['SN_USERNAME'], :sn_password => ENV['SN_PASSWORD'])
      sys_id = ServiceNow::User.find(person.netid).sys_id
      
      @name = person.name
      @email = person.email
      @affiliation = "Undergraduate"
      @sn_destination_url = "https://yale.service-now.com/incident.do?sys_id=-1&sysparm_query=caller_id=" + sys_id + "^u_contact=" + sys_id
      @phonebook_destination_url = "http://directory.yale.edu/phonebook/index.htm?searchString=upi%3D" + upi
    end
  end

  # def servicenowlookup
  #   authorize! :lookup, :servicenow
    

  #   redirect_to servicenow_path
  #   # render 'servicenow.html.erb'
  # end


end
