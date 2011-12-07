
Feature: Bucket handling

  In order to determine which requests weren't handled
  As a client application
  It should list all unhandled requests in the bucket

  Scenario Outline: Perform an unhandled request
    Given the test layouts
      And the layout 'one'
     When the unhandled <method> request is performed
     Then the response for unhandled <method> request should be returned
      And the bucket should contain the unhandled <method> request
    Examples:
      | method |
      | post   |
      | put    |
      | get    |
      | delete |
