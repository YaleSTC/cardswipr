module ApplicationHelper
  def yale_directory_link(upi)
    "http://directory.yale.edu/?queryType=field&upi=#{upi}"
  end

  def breadcrumbs(*labels)
    links = labels[0...labels.size-1]
    last = labels.last

    html = '<div class="row"><ol class="breadcrumb">'
    links.each do |link|
      html << case link
      when 'home'
        "<li>#{link_to 'Home', '/'}</li>"
      when 'events'
        "<li>#{link_to 'Events', events_path}</li>"
      when 'event'
        "<li>#{link_to @event.title, event_path(@event)}</li>"
      when 'entry'
        "<li>#{link_to @attendance_entry.name, attendance_entry_path(@attendance_entry)}</li>"
      when 'entry.event'
        "<li>#{link_to @attendance_entry.event.title, event_attendance_entries_path(@attendance_entry.event)}</li>"
      else
        raise "Unrecognized breadcrumb ID #{link}"
      end
    end

    html << case last
    when 'event'
      "<li>#{@event.title}</li>"
    when 'entry'
      "<li>#{@attendance_entry.name}</li>"
    else
      "<li>#{last}</li>"
    end

    html + '</ol></div>'
  end

  def helper_paginate(model_collection)
    will_paginate(model_collection,
      previous_label: icon('caret-left') + ' Previous',
      next_label: 'Next ' + icon('caret-right'))
  end
end
