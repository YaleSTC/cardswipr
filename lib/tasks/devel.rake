# Tasks to facilitate local development
namespace :devel do
  desc "Delete all swipe entries for the event with the title :event_title"
  task :delete_swipes, [:event_title] => :environment do |_t, args|
    event = Event.find_by(title: args[:event_title])
    event.attendance_entries.delete_all
  end
end
