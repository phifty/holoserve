
Feature: Layout handling

  In order control behaviour of holoserve
  As a random user
  I should be able to set and get the internal layout configuration

  Scenario: Set the current layout
    Given the test layouts
     When the layout 'one' is set to be the current layout
     Then the responded status code should be 200
      And the current layout should be 'one'
