
Feature: Fake handling of oauth requests

  In order to replace a oauth Web api
  As a oauth client application
  It should handle all oauth http requests

  Scenario: Consumer fetches access token
    Given the situation 'three'
      And the test oauth consumer
     When the request token is requested
      And the access token is requested
      And the oauth test get request is performed
     Then the history should contain the pair name 'request_token_requested'
      And the history should contain the pair name 'access_token_requested'
      And the history should contain the pair name 'oauth_test_requested'
