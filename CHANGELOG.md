# Changelog

This file should be updated before a new release is deployed.

## 2.0.0 (Unreleased)
### Changed
* Modified README to reflect v2.0 [#132](https://gitlab.com/yale-sdmp/cardswipr/issues/132)
* Modified associations between Event and Attendance [#145](https://gitlab.com/yale-sdmp/cardswipr/issues/145)
* Removed explicit namespacing of method calls to FactoryBot [#150](https://gitlab.com/yale-sdmp/cardswipr/issues/150)
* Modified error messages to be more helpful [#162](https://gitlab.com/yale-sdmp/cardswipr/issues/162)
* Modified Application Controller to correctly reroute unauth users [#128](https://gitlab.com/yale-sdmp/cardswipr/issues/128)
* Fixed style checker [#158](https://gitlab.com/yale-sdmp/cardswipr/issues/158)
* User email address is persisted on first login [#149](https://gitlab.com/yale-sdmp/cardswipr/issues/149)
* Changed check-in time display [#172](https://gitlab.com/yale-sdmp/cardswipr/issues/172)
* Prevented users from accessing events for which they are not organizers [#163](https://gitlab.com/yale-sdmp/cardswipr/issues/163)
* Replaced chromedriver-helper with webdrivers [#174](https://gitlab.com/yale-sdmp/cardswipr/issues/174)
* Changed dashboard to display events from newest to oldest [#179](https://gitlab.com/yale-sdmp/cardswipr/issues/179)
* Removed unused routes in config/routes.rb and in controllers [#181](https://gitlab.com/yale-sdmp/cardswipr/issues/181)
* Moved determine_key from AttendanceCreator to PeopleHub module [#187](https://gitlab.com/yale-sdmp/cardswipr/issues/179)
* Made PeopleHub requests fail silently when a new user logs in [#170](https://gitlab.com/yale-sdmp/cardswipr/issues/170)
* Changed edit event page to display organizer names [#189](https://gitlab.com/yale-sdmp/cardswipr/issues/189)
* Changed the adding organizers input to a text field that expects a netID [#171](https://gitlab.com/yale-sdmp/cardswipr/issues/171)
* Changed from the compiled yale-ui to using the src .scss files [#196](https://gitlab.com/yale-sdmp/cardswipr/issues/196)
* Modified check-in behavior to address user feedback [#212](https://gitlab.com/yale-sdmp/cardswipr/issues/212)
* Upgraded to rails 6.0 and ruby 2.6.5 [#214](https://gitlab.com/yale-sdmp/cardswipr/issues/214)
* Updated event creation to allow events with preregistation [#220](https://gitlab.com/yale-sdmp/cardswipr/-/issues/220)
* Updated attendance creator to handle events with preregistration [#221](https://gitlab.com/yale-sdmp/cardswipr/issues/221)

### Added
* Added User model [#107](https://gitlab.com/yale-sdmp/cardswipr/issues/107)
* Added CAS authentication via Devise [#108](https://gitlab.com/yale-sdmp/cardswipr/issues/108)
* Added Event model [#110](https://gitlab.com/yale-sdmp/cardswipr/issues/110)
* Added Attendance model [#120](https://gitlab.com/yale-sdmp/cardswipr/issues/120)
* Added User-Event and Event-Attendance join models [#144](https://gitlab.com/yale-sdmp/cardswipr/issues/144)
* Added Attendance Controller [#136](https://gitlab.com/yale-sdmp/cardswipr/issues/136)
* Added Event Controller [#135](https://gitlab.com/yale-sdmp/cardswipr/issues/135)
* Created dashboard where user's events are displayed [#113](https://gitlab.com/yale-sdmp/cardswipr/issues/113)
* Added Fixtures for testing API [#137](https://gitlab.com/yale-sdmp/cardswipr/issues/137)
* Created a button on dashboard to delete an event [#116](https://gitlab.com/yale-sdmp/cardswipr/issues/116)
* Added Attendance List View [#126](https://gitlab.com/yale-sdmp/cardswipr/issues/126)
* Created page where Users can create an event [#111](https://gitlab.com/yale-sdmp/cardswipr/issues/111)
* Added organizer update to Event Edit form [#153](https://gitlab.com/yale-sdmp/cardswipr/issues/153)
* Updated Gemfile to refer to specific version numbers [#157](https://gitlab.com/yale-sdmp/cardswipr/issues/157)
* Added basic Event edit page [#114](https://gitlab.com/yale-sdmp/cardswipr/issues/114)
* Fixed style checker [#158](https://gitlab.com/yale-sdmp/cardswipr/issues/158)
* Added API interface for Yale's Identity Server [#138](https://gitlab.com/yale-sdmp/cardswipr/issues/138)
* Implemented Bootstrap [#154](https://gitlab.com/yale-sdmp/cardswipr/issues/154)
* Added confirmation dialogue when deleting events [#160](https://gitlab.com/yale-sdmp/cardswipr/issues/160)
* Added export button for exporting Event Attendances [#127](https://gitlab.com/yale-sdmp/cardswipr/issues/127)
* Created Seed Script for Database [#148](https://gitlab.com/yale-sdmp/cardswipr/issues/148)
* Created event check in page [#119](https://gitlab.com/yale-sdmp/cardswipr/issues/119)
* Extended PeopleHub workaround [#159](https://gitlab.com/yale-sdmp/cardswipr/issues/159)
* Added missing fields in CSV Export [#164](https://gitlab.com/yale-sdmp/cardswipr/issues/164)
* Added the complete public home page [#165](https://gitlab.com/yale-sdmp/cardswipr/issues/165)
* Added name to User model [#156](https://gitlab.com/yale-sdmp/cardswipr/issues/156)
* Added missing 'Back to Dashboard' buttons [#169](https://gitlab.com/yale-sdmp/cardswipr/issues/169)
* Added ability for users to delete attendances [#173](https://gitlab.com/yale-sdmp/cardswipr/issues/173)
* Added user profile page [#167](https://gitlab.com/yale-sdmp/cardswipr/issues/167)
* Added the User Manual page [#166](https://gitlab.com/yale-sdmp/cardswipr/issues/166)
* Added number of attendees to check-in page [#178](https://gitlab.com/yale-sdmp/cardswipr/issues/178)
* Added footer [#168](https://gitlab.com/yale-sdmp/cardswipr/issues/168)
* Setup email functionality with mandrill [#177](https://gitlab.com/yale-sdmp/cardswipr/issues/177)
* Added Person Lookup ability [#140](https://gitlab.com/yale-sdmp/cardswipr/issues/140)
* Added heartbeat route for the api [#184](https://gitlab.com/yale-sdmp/cardswipr/issues/184)
* Added pictures to home page [#188](https://gitlab.com/yale-sdmp/cardswipr/issues/188)
* Added email validations to user model [#192](https://gitlab.com/yale-sdmp/cardswipr/issues/192)
* Added icons to nav bar [#193](https://gitlab.com/yale-sdmp/cardswipr/issues/193)
* Add a database import via exported table CSVs [#185](https://gitlab.com/yale-sdmp/cardswipr/issues/185)
* Added Yale Boostrap styles [#176](https://gitlab.com/yale-sdmp/cardswipr/issues/176)
* Added a database import via exported table CSVs [#185](https://gitlab.com/yale-sdmp/cardswipr/issues/185)
* Added Roles to Users and added pundit policies to handle this new role [#183](https://gitlab.com/yale-sdmp/cardswipr/issues/183)
* Added Administrate [#182](https://gitlab.com/yale-sdmp/cardswipr/issues/182)
* Added pagination [#204](https://gitlab.com/yale-sdmp/cardswipr/issues/204)
* Added ability to use the magstripe swipe [#207](https://gitlab.com/yale-sdmp/cardswipr/issues/207)
* Added bundler audit [#209](https://gitlab.com/yale-sdmp/cardswipr/issues/209)
* Added host header attack protection [#215](https://gitlab.com/yale-sdmp/cardswipr/issues/215)
* Added pregregistration bool to event model [#217](https://gitlab.com/yale-sdmp/cardswipr/issues/217)
* Created preregistration model [#218](https://gitlab.com/yale-sdmp/cardswipr/-/issues/218)
* Added ability to view event preregistration info [#219](https://gitlab.com/yale-sdmp/cardswipr/-/issues/219)
* Added ability to delete preregistrations [#224](https://gitlab.com/yale-sdmp/cardswipr/-/issues/224)
* Allowed event organizers to add preregistrations [#223](https://gitlab.com/yale-sdmp/cardswipr/-/issues/223)

### Fixed
* Fixed NoMethodError caused when you click on User Manual [#180](https://gitlab.com/yale-sdmp/cardswipr/issues/180)
* Fixed last use column on dashboard [#190](https://gitlab.com/yale-sdmp/cardswipr/issues/190)
* Fixed naming collision with .env files and dotenv gem [#199](https://gitlab.com/yale-sdmp/cardswipr/issues/199)
* Fixed validations on the params parser to be more flexible with netids [#206](https://gitlab.com/yale-sdmp/cardswipr/issues/206)
* Fix pagination conflict with administrate gem [#205](https://gitlab.com/yale-sdmp/cardswipr/issues/205)
* Fix double submission bug with magstripe swipes [#210](https://gitlab.com/yale-sdmp/cardswipr/issues/210)

## 1.3.6
<small>7/3/2017</small>
Bugfix: updated API URL for production. Had forgotten to update it in 1.3.5.

## 1.3.5
<small>7/2/2017</small>
As remediation for trainsition to Workday, CardSwipr is now using a differnet API entry point for the ID data: (https://gw.its.yale.edu/soa-gateway/v2/identity) with a different method of authentication.

## 1.3.4
<small>12/4/2015</small>

* Lists of events and users are now paginated.
* Event admin selection list (for event creation/edit) is now sorted by name.

## 1.3.3
<small>11/25/2015</small>

* Fixed the bug of user attributes not being saved when a new user is created.
* Set force_ssl = true in development environment too.

## 1.3.2
<small>11/23/2015</small>

* Misc. bug fix with configuration for production environment.

## 1.3.1
<small>11/20/2015</small>

* Deleted unused columns from display and csv export.
* Misc. style updates.

## 1.3.0
<small>11/20/2015</small>

* The application is now using the new CardSwipr API. Both Yale LDAP and the CardSwipr Oracle database are not used any more.
