
Feature: Bucket handling

  In order to determine which requests weren't handled
  As a client application
  It should list all unhandled requests in the bucket

  Scenario: Perform a unhandled request
     When the test unhandled request is performed
     Then the bucket should contain the test unhandled request

  Scenario: Clear the bucket
    Given a bucket containing the test unhandled request
     When the bucket is cleared
     Then the bucket should be empty
