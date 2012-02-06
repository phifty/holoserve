
Feature: Bucket handling

  In order to determine which requests weren't handled
  As a client application
  It should list all unhandled requests in the bucket

  Scenario: Perform a request without any layout loaded
    Given no pairs
     When the test request is performed
     Then the bucket should contain the test request

  Scenario: Clearing the bucket
    Given a bucket containing the test request
     When the bucket is cleared
     Then the bucket should be empty
