##  Integration Tests
  - Person Lookup - swipe card, page is rendered with two functioning links
  - Event Swipe - swipe card, person shows up in full list page (both html and csv)

## Model Tests
- YaleIDLookup#lookup
  - swipe card, someone is searched, person is returned - `don't want to hard-code in someone's card number, let's not test this formally?``
  - type netid, someone is searched, person is returned - `done!`
  - prox card, someone is searched, person is returned
  post-search action (not yet, pending test) - `don't want to hard-code in someone's card number, let's not test this formally?``

## Controller test?
- #swipe
  - person is returned, person is added to the event list (backend)
  event lists
  - someone is added to event list (backend), this is visible in the csv
  - someone is added to event list (backend), this is visible in the html table page
  - someone is removed from the event list (backend), they no longer appear in the csv
  - someone is removed from the event list (backend), they no longer appear in the html table page
  user login
  - someone logs in, they have an account created
  user permissions

# Permissions testing
  - someone logs in as admin, can see x y z
  - someone logs in as user, can see x y z
  event ownership
  - someone logs in, they can [see events] they're admin of
  - someone logs in, they can't [see events] they're not admin of
  [see events] means can
  - view events/index entries
  - event card-swipe page
  - event table page
  - event html output, csv output