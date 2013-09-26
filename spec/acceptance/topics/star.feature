Feature: Star a topic

  As a user
  I want to star valuable topic
  in order to go back to it easily

  Background:
    Given I am signed in
    When I visit an existed topic

  Scenario: signed in user star a topic and unstar it
    Then I should see star
    When I click star
    Then I should see unstar
    When I click unstar
    Then I should see star

  Scenario: unsigned in user can't see star
    Given I am not signed in
    When I visit an existed topic
    Then I should not see star
