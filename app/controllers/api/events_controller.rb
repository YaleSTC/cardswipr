module Api
  class EventsController < Api::BaseController

    private

      def event_params
        params.require(:event).permit(:title)
      end

      def query_params
        # this assumes that an album belongs to an artist and has an :artist_id
        # allowing us to filter by this
        params.permit(:event_id, :title)
      end

  end
end
