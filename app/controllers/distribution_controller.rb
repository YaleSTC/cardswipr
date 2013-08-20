class DistributionController < ApplicationController

  def index
    @count = Student.count
  end

  def lookup
    person = Person.search(params[:query])

    if person.nil?
      @message = "I'm sorry, Dave, I didn't find anyone" and return
    end

    unless person.freshman?
      @message = "#{person.name} doesn't appear to be a freshman." and return
    end

    if person.given_key?
      @message = "#{person.name} has already been given a USB Key" and return
    end

    if person.give_key
      @message = "#{person.name} has been verifed. You may give them a flash drive."
    else
      @message = "Unexpected error (trying to save that we gave person a key). You may getm them a key anyway and make a note of this."
    end

  end

end
