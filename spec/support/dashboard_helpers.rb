# frozen_string_literal: true

# dashboard helper function
def get_event_rows(page)
  page.all(:id, 'event row')
end
