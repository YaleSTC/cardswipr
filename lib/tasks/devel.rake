# Tasks to facilitate local development
namespace :devel do
  desc "Delete all swipe entries for the event with the title :event_title"
  task :delete_swipes, [:event_title] => :environment do |_t, args|
    title = args[:event_title]
    event = Event.find_by(title: title)
    if event
      event.attendance_entries.destroy_all
    else
      puts "Event \"#{title}\" does not exist."
    end
  end

  desc "Delete a user - by netid"
  task :delete_user, [:netid] => :environment do |_t, args|
    netid = args[:netid]
    user = User.find_by(netid: netid)
    if user
      user.destory
    else
      puts "User with NetID=#{netid} does not exist."
    end
  end
end
