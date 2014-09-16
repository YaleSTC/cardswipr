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

    if person.given_key?
      flash[:error] = "#{person.name} has already been given a USB Key"
      redirect_to :distribution_index and return
    end

    if person.give_key
      flash[:notice] = "#{person.name} has been verifed. You may give them a flash drive."
      @count = Student.count
    else
      flash[:error] = "Unexpected error (trying to save that we gave person a key). You may give them a key anyway and make a note of this."
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
