# frozen_string_literal: true

# dashboard helper function
def get_event_rows(page)
  table = page.find(:css, 'table#events')
  table.all(:css, 'tbody/tr')
end
