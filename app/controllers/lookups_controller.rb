# frozen_string_literal: true

# controller for Person Lookups
class LookupsController < ApplicationController
  def index; end

  def create
    @creator = LookupCreator.new(
      search_param: params[:search_param]
    )
    if @creator.call
      render 'index', locals: { lookup: @creator.lookup }
    else
      redirect_to lookups_path, alert: 'Look-up failed'
    end
  end

  private

  def authorize!; end
end
