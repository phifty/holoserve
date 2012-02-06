
Feature: Situation handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get it's current situation

  Scenario: Set the current situation
    Given no situation
     When the situation 'one' is set to be the current one
     Then the current situation should be 'one'

  Scenario: Clear the current situation
    Given the situation 'one'
     When the current situation is cleared
     Then there should be no situation set
