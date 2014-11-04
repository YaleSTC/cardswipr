class PagesController < ApplicationController
  include HighVoltage::StaticPage

  skip_authorization_check
end