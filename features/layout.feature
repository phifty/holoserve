
Feature: Layout handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get the internal layout configuration

  Scenario Outline: Set the layout
     When the <test or invalid> layout are set
     Then the responded status code should be <status code>
      And the responded body should <include or not include> an acknowledgement
    Given the test layout
    Examples:
      | test or invalid | status code | include or not include |
      | test            | 200         | include                |
      | invalid         | 400         | not include            |
