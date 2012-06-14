
Feature: History handling

  In order to determine the request history
  As a client application
  It should list the names of the triggered request/response-pairs

  Scenario: A pair is triggered
    Given no history
     When the test request is performed
     Then the history should contain the test pair name

  Scenario: A pair is triggered
    Given a history exists
     When the test request is performed
     Then the history should contain the test pair name at the last position

  Scenario: A pair is triggered
    Given no history
     When the test request is performed
     Then the history should contain the request variant

  Scenario: A pair is triggered
   Given no history
    When the test request is performed
    Then the history should contain the list of response variants

  Scenario: The history is cleared
    Given a history containing only the test pair name
     When the history is cleared
     Then the history should be empty