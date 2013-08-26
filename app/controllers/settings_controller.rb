class SettingsController < ApplicationController
  before_action :set_setting

  def index
    redirect_to @setting
  end
  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/1/edit
  def edit
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Settings successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_setting
      # If settings have been saved, use them, otherwise, create defaults
      @setting = Setting.first || Setting.create_default
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:allowed_years)
    end
end
