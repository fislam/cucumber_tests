@testing
Feature: PIPPA alert


  Scenario: Creating an alert for PIPPA
    Given I create a PIPPA alert with valid JSON data
    Then I should get a valid response
      And a valid JSON schema
    When I create a PIPPA alert with bad data in the JSON
    Then I should get a "200" http status code
      And an error message in the response



