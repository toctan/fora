Feature: Mention notification
  As a user
  I want to be notified when mentioned in reply or topic
  So that I can reply

  Background:
    Given I am signed in

  Scenario: Mentioned in new topic
    When someone mentions me in new topic
    And I visit the homepage
    Then I should see new notification

  Scenario: Mentioned in new reply
    When someone mentions me in new reply
    And I visit the homepage
    Then I should see new notification
