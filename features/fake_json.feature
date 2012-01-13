
Feature: Fake handling of requests with json response

  In order to replace a json web api
  As a client application
  It should handle all http requests and respond with json

  Scenario: Handle request with json response
    Given the situation 'two'
     When the regular test get request is performed
     Then the responded status code should be 200
      And the json response for test get request should be returned
