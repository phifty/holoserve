
Feature: State handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get it's current state

  Scenario: Set and get the current state
     When the state of resource 'user' is set to 'new'
     Then the state of resource 'user' should be 'new'

  Scenario: Clearing the state
    Given the test state
     When the state is cleared
     Then the state should be undefined
