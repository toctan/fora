Feature: Topic reply notification

  As a topic starter
  I want to be notified upon new reply
  So that I can see replies instantly

  Background:
    Given I am signed in
    And I have posted a topic

  Scenario: Topic starter get notified when other users reply
    When another user replies my topic
    And I visit the homepage
    Then I should see new notification
    When I visit '/notifications'
    Then I should not see the notification indicator

  Scenario: Topic starter get notified only one when mentioned in reply
    When another user mentiones me in my topic's reply
    And I visit '/notifications'
    Then I should see only 1 new notification
