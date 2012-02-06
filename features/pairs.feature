
Feature: Handling pairs

  In order to control the behaviour of holoserve
  As a client application
  It should be possible to CRUD request/response pairs

  Scenario Outline: Adding a pair
    Given no pairs
     When the <format> pairs are added
     Then the pair should be <present or absent>
    Examples:
      | format  | present or absent |
      | yaml    | present           |
      | json    | present           |
      | invalid | absent            |
