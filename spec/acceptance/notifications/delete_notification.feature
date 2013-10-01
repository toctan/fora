Feature: Delete notification

  As a user
  I want to delete unnecessay notifications

  Background:
    Given I am signed in
    And there exists a bunch of notifications
    And I am on the notification page

  Scenario: Delete single notification
    When I click delete on one of the notifications
    Then I should see this notification removed
    
  Scenario: Clear all notifications
    When I click Clear
    Then I should see no notifications
