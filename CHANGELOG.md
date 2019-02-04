# Changelog

This file should be updated before a new release is deployed.

## 2.0.0 (Unreleased)
### Changed

### Added
* Added User model [#107](https://gitlab.com/yale-sdmp/cardswipr/issues/107)
* Added CAS authentication via Devise [#108](https://gitlab.com/yale-sdmp/cardswipr/issues/108)

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
