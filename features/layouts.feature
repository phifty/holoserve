
Feature: Layout handling

  In order control behaviour of holoserve
  As a random user
  I should be able to set and get the internal layout configuration

  Scenario Outline: Set the layouts
     When the <test or invalid> layouts are set
     Then the responded status code should be <status code>
      And the available layouts should <include or not include> 'one'
      And the available layouts should <include or not include> 'two'
    Examples:
      | test or invalid | status code | include or not include |
      | test            | 200         | include                |
      | invalid         | 400         | not include            |

  Scenario Outline: Set the current layout
    Given the test layouts
     When the layout '<layout>' is set to be the current layout
     Then the responded status code should be <status code>
      And the current layout should be '<current layout>'
    Examples:
      | layout  | status code | current layout |
      | one     | 200         | one            |
      | invalid | 404         | one            |
