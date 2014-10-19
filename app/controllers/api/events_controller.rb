module Api
  class EventsController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json
    load_and_authorize_resource param_method: :event_params

    # POST /api/{plural_resource_name}
    def create
      if @event.save
        render :show, status: :created
      else
        render json: event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/{plural_resource_name}/1
    def destroy
      @event.destroy
      head :no_content
    end

    # GET /api/{plural_resource_name}
    def index
      respond_with @events.to_json
    end

    # GET /api/{plural_resource_name}/1
    def show
      respond_with @event.to_json
    end

    # PATCH/PUT /api/{plural_resource_name}/1
    def update
      if @event.update(event_params)
        render :show
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end


    private

      def event_params
        params.require(:event).permit(:title)
      end

      # def query_params
      #   # this assumes that an album belongs to an artist and has an :artist_id
      #   # allowing us to filter by this
      #   params.permit(:event_id, :title)
      # end

  end
end
