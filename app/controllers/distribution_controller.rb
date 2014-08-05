class DistributionController < ApplicationController

  def index
    @count = Student.count
  end

  def lookup
    person = Person.search(params[:query])

    # if person.nil?
    #   flash.now[:error] = "I'm sorry, Dave, I didn't find anyone"
    #   redirect_to :distribution_index
    # end

    unless person.allowed_year?
      flash[:error] = "#{person.name} is not in the allowed class years."
      redirect_to :distribution_index and return
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
  end

  def phonebooklookup
    person = Person.search(params[:query])
    redirect_to "http://directory.yale.edu/phonebook/index.htm?searchString=netid%3D" + person
  end

end
