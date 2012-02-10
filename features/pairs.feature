
Feature: Handling pairs

  In order to control the behaviour of holoserve
  As a client application
  It should be possible to CRUD request/response pairs

  Scenario Outline: Adding a pair
    Given no pairs
     When the <format> pairs are added
     Then the test pair should be <present or absent>
    Examples:
      | format  | present or absent |
      | yaml    | present           |
      | json    | present           |
      | invalid | absent            |

  Scenario: Listing all pairs
    Given the test fixtures
      And the test pairs
     Then the list of pairs should contain the test pair
      And the list of evaluated pairs should contain the evaluated test parameters pair
