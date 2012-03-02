
Feature: Fake handling of requests

  In order to replace a web api
  As a client application
  It should handle all http requests

  Scenario: Handle a request
    Given the test state
     When the test request is performed
     Then the test response should be returned

  Scenario: Handle a request with parameters
    Given the test state
     When the test request is performed with the test parameters
     Then the test parameters response should be returned

  Scenario: Handle a request with headers
    Given the test state
     When the test request is performed with the test headers
     Then the test headers response should be returned

  Scenario: Handle a request that respond json
    Given the test state
     When the test json request is performed
     Then the test json response should be returned

  Scenario: Handle a request with oauth headers
    Given the test state
     When the test request is performed with the test oauth headers
     Then the test oauth response should be returned

  Scenario: Handle request without a situation set
    Given no defined state
     When the test request is performed
     Then the test response default should be returned
