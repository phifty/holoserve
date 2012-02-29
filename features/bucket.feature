
Feature: Bucket handling

  In order to determine which requests weren't handled
  As a client application
  It should list all unhandled requests in the bucket

  Scenario: Perform a request without any layout loaded
     When the test unhandled request is performed
     Then the bucket should contain the test unhandled request
