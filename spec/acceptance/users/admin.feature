Feature: Admin

  As an admin
  I want to have some penimissions
  So that I can manage this site

  Scenario: Common delete a topic
    Given I am signed in
    When  I visit an existed topic
    Then  I should not see delete link


  Scenario: Admin delete a topic
    Given I am an admin and signed in
    When I visit an existed topic
    Then I should see delete link
    When I click delete link
    Then I should see 'delete topic successfully' message


