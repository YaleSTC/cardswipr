This application does two things using Yale ID Cards:
1. Event Attendance - Keeps track of people who have swiped their ID cards at an event.
2. Phonebook Lookup - When someone swipes their card at a walk-in center, the Yale Phonebook entry is instantly opened up.

It connects to the Yale Oracle database to convert the magnetic stripe information on the Yale ID to identifiable information.

##Set Up
###ruby-oci8 gem
To set this up, you must install the ruby-oci8 gem by following the instructions here:
https://github.com/kubo/ruby-oci8/blob/master/docs/install-instant-client.md

Troubleshooting install: 
Make sure to change all the commands for the OS you're using and your version numbers e.g. .so -> .dylib, the 11_number _ things
Also you may need to do ruby -e "require 'oci8'"

###Database Connection Information
A sample database.yml is available in Yale's private git repository (but it is private).

##Application Structure
An explanation of the application structure, what models are used for what, and how the flow of the application works, see [our wiki](https://github.com/YaleSTC/key_distribution_v2/wiki)
