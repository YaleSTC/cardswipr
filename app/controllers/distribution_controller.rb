class DistributionController < ApplicationController

  def index
    @count = Student.count
  end

  def lookup
    person = Person.search(params[:query])

    if person.nil?
      flash.now[:error] = "I'm sorry, Dave, I didn't find anyone" and return
    end

    unless person.allowed_year?
      flash.now[:error] = "#{person.name} is not in the allowed class years." and return
    end

    if person.given_key?
      flash.now[:error] = "#{person.name} has already been given a USB Key" and return
    end

    if person.give_key
      flash.now[:notice] = "#{person.name} has been verifed. You may give them a flash drive."
      @count = Student.count
    else
      flash.now[:error] = "Unexpected error (trying to save that we gave person a key). You may give them a key anyway and make a note of this."
    end
    redirect_to action: :index
  end

  def phonebook
  end

  def phonebooklookup
    netid = params[:query]
    redirect_to "http://directory.yale.edu/phonebook/index.htm?searchString=netid%3D" + netid
  end

end
