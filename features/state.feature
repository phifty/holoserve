
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

  Scenario: Handling a request that has transitions
    Given the test state
     When the test request is performed
     Then the state should have been updated

  Scenario: Set the state to last paired request variant
    Given the test state
     When a matching request is paired
     Then the state should have been updated