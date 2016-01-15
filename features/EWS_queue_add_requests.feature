@TOOL-178-EWS-add-queue-request
Feature: Add queue request


  Scenario: Queue add request
    Given the customer is currently not installed in EWS
    And an add request is currently not in flight awaiting a response from the vendor
    When subscriber has requested an activation of EWS tool
    Then I should queue an add request

