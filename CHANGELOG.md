# Changelog

This file should be updated before a new release is deployed.

## 2.0.0 (Unreleased)
### Changed
* Modified README to reflect v2.0 [#132](https://gitlab.com/yale-sdmp/cardswipr/issues/132)
* Modified associations between Event and Attendance [#145](https://gitlab.com/yale-sdmp/cardswipr/issues/145)
* Removed explicit namespacing of method calls to FactoryBot [#150](https://gitlab.com/yale-sdmp/cardswipr/issues/150)

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
* Added API interface for Yale's Identity Server [#138](https://gitlab.com/yale-sdmp/cardswipr/issues/138)
* Created event check in page [#119](https://gitlab.com/yale-sdmp/cardswipr/issues/119)

### Fixed

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
