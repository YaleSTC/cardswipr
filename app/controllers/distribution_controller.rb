class DistributionController < ApplicationController
  # load_and_authorize_resource #this doesn't work because there's no distribution model?
  # authorize_resource #not load_and_authorize_resource because there's no model
  # skip_authorization_check #this isn't what we want because we do need authorization

  def index
    authorize! :open, :cardswipe
    @count = Student.count
  end

  def lookup
    authorize! :lookup, :cardswipe
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
    authorize! :open, :phonebook
  end

  def phonebooklookup
    authorize! :lookup, :phonebook
    person = Person.search(params[:query])
    redirect_to "http://directory.yale.edu/phonebook/index.htm?searchString=netid%3D" + person.netid
  end

end
