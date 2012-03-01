
Feature: Handling pairs

  In order to see which pairs has been loaded
  As a client application
  It should be possible to list all or fetch a single pair

  Scenario: List all pairs
     When the list of pairs is fetched
     Then the returned list should contain the pair of the test request

  Scenario: Fetch a specific pair
     When the pair of the test request is fetched
     Then the returned pair should contain the test request

  Scenario: Fetch a evaluated pair
     When the pair of the test evaluation request is fetched
     Then the returned pair should contain the test evaluation request
