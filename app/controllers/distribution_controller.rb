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

  def phonebook
    authorize! :read, :phonebook
  end

  def phonebooklookup
    authorize! :lookup, :phonebook
    upi = Person.lookup(params[:query])
    redirect_to "http://directory.yale.edu/phonebook/index.htm?searchString=upi%3D" + upi
  end

end
