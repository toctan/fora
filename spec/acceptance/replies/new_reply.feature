Feature: Reply a topic
  As a user
  I want to reply an interesting topic
  So that I can join the discussion

  Scenario: Signed in user reply a topic
    Given I am signed in
    And I visit an existed topic
    Then I should see a reply form
    When I submit the form with my reply
    Then I should see my reply on the bottom
