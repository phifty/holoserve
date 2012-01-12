
Feature: Situation handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get it's current situation

  Scenario: Set the current situation
     When the situation 'one' is set to be the current one
     Then the responded status code should be 200
      And the responded body should include an acknowledgement
      And the current situation should be 'one'
