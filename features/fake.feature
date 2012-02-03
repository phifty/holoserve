
Feature: Fake handling of requests

  In order to replace a web api
  As a client application
  It should handle all http requests

  Scenario Outline: Handle request
    Given the situation 'one'
     When the regular test <method> request is performed
     Then the response for test <method> request should be returned
    Examples:
      | method |
      | post   |
      | put    |
      | get    |
      | delete |

  Scenario Outline: Handle request with parameters
    Given the situation 'one'
     When the regular test <method> request is performed with parameter set '<parameter set>'
     Then the response for test <method> request should be returned
    Examples:
      | method | parameter set |
      | post   | one           |
      | put    | one           |
      | get    | one           |
      | delete | one           |

  Scenario Outline: Handle request with headers
    Given the situation 'one'
     When the regular test <method> request is performed with header set '<header set>'
     Then the response for test <method> request should be returned
    Examples:
      | method | header set |
      | post   | one        |
      | put    | one        |
      | get    | one        |
      | delete | one        |

  Scenario: Handle request without a situation set
    Given no situation
     When the regular test get request is performed
     Then the default response for test get request should be returned
