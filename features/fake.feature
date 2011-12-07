
Feature: Fake handling of requests

  In order to replace a web API
  As a client application
  It should handle all http requests

  Scenario Outline: Handle request
    Given the test layouts
      And the layout 'one'
     When a <method> request is performed
     Then the expected response should be returned
    Examples:
      | method |
      | post   |
      | put    |
      | get    |
      | delete |
