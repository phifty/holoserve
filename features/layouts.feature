
Feature: Layout handling

  In order control behaviour of holoserve
  As a client application
  It should be possible to set and get the internal layout configuration

  Scenario Outline: Set the layouts
     When the <test or invalid> layouts are set
     Then the responded status code should be <status code>
      And the responded body should <include or not include> an acknowledgement
      And the available layouts should <include or not include> 'one'
      And the available layouts should <include or not include> 'two'
    Given the test layouts
    Examples:
      | test or invalid | status code | include or not include |
      | test            | 200         | include                |
      | invalid         | 400         | not include            |

  Scenario Outline: Set the current layout
     When the layout '<layout>' is set to be the current layout
     Then the responded status code should be <status code>
      And the responded body should <include or not include> an acknowledgement
      And the current layout should be '<current layout>'
    Examples:
      | layout  | status code | include or not include | current layout |
      | one     | 200         | include                | one            |
      | invalid | 404         | not include            | one            |

  Scenario: List available layout ids
    Given the test layouts
     Then the available layouts should include 'one'
      And the available layouts should include 'two'

  Scenario: List available layout ids without any layouts loaded
    Given a clear layouts setting
     Then the available layouts should be empty
