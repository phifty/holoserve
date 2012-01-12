
Feature: Layout handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get the internal layout configuration

  Scenario Outline: Set the layouts
     When the <test or invalid> layouts are set
     Then the responded status code should be <status code>
      And the responded body should <include or not include> an acknowledgement
    Given the test layouts
    Examples:
      | test or invalid | status code | include or not include |
      | test            | 200         | include                |
      | invalid         | 400         | not include            |

  Scenario: Set the current situation
     When the situation 'one' is set to be the current one
     Then the responded status code should be 200
      And the responded body should include an acknowledgement
      And the current situation should be 'one'
