# frozen_string_literal: true

require 'rake'

# rubocop:disable Metrics/LineLength
# Usage - bundle exec rake data_import users.csv events.csv events_users.csv attendance_entries.csv
## Note - these are relative paths to the csvs
desc 'Import data from old cardswipr csvs- has 4 parameters the users table path, the events table path, the event_user table path, and the attendance_entries path'
task :data_import, %i(user_table_path event_table_path event_user_table_path attendance_entries_table_path) => [:environment] do
  importer = DataImporter.new(user_table_path: ARGV[1],
                              event_table_path: ARGV[2],
                              event_user_table_path: ARGV[3],
                              attendance_entries_table_path: ARGV[4])
  if importer.call
    puts 'Successful import'
  else
    puts 'Unable to import'
  end
end
# rubocop:enable Metrics/LineLength
