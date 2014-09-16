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
      flash[:error] = "#{person.name} has already had the access request recorded"
      redirect_to :distribution_index and return
    end

    if person.give_key
      flash[:notice] = "#{person.name}'s access request has been recorded."
      @count = Student.count
    else
      flash[:warning] = "Unexpected error (trying to save the access request). Email dev-mgt@yale.edu."
    end

    redirect_to :distribution_index

  end

  def phonebook
  end

  def phonebooklookup
    person = Person.search(params[:query])
    redirect_to "http://directory.yale.edu/phonebook/index.htm?searchString=netid%3D" + person.netid
  end

end
