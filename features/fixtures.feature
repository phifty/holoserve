
Feature: Handling fixtures

  In order to shared data between the request/response-pairs
  As a client application
  It should be possible to CRUD fixtures

  Scenario Outline: Adding fixtures
    Given no fixtures
     When the <format> fixtures are added
     Then the test fixture should be <present or absent>
    Examples:
      | format  | present or absent |
      | yaml    | present           |
      | json    | present           |
      | invalid | absent            |
