
Feature: History handling

  In order to determine the request history
  As a client application
  It should list the names of the triggered request/response-pairs

  Background:
    Given the test pairs

  Scenario: A pair is triggered
    Given no history
     When the test request is performed
     Then the history should contain the test pair name

  Scenario: The history is cleared
    Given a history containing only the test pair name
     When the history is cleared
     Then the history should be empty
