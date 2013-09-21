Feature: New topic

  As a user
  I want to create new topics
  So that I can start a discussion

  Scenario: Signed user creates simple topic
    Given I am signed in
    And I am on the new topic page
    When I submit with the topic's title
    Then I should see the topic created

  Scenario: Unsigned user tries to create new topic
    Given I am not signed in
    When I visit the new topic page
    Then I should see "You need to sign in" message
