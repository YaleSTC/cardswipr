# frozen_string_literal: true

# Controller for static pages
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def user_manual; end

  private

  def public_action?
    %w(home).include?(params[:id])
  end

  def authorize!; end
end
