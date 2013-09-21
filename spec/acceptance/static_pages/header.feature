Feature: Header
  As a visitor
  When I visit home page

  Scenario: User visit /
    Given I am not signed in
    When I visit the homepage
    Then I should see sign_up sign_in links



  Scenario: User visit /
    Given I am signed in
    When I visit the homepage
    Then I should not see sign_up sign_in links
    And  I should see sign_out settings links
    When I click sign_out link
    Then I should see sign_up sign_in links
    And  I should not see sign_out settings links
