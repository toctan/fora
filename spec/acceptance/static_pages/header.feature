Feature: Header

  As a visitor
  I want to visit home page

  Scenario: Unsigned in user visit homepage
    Given I am not signed in
    When I visit the homepage
    Then I should see sign_up sign_in links

  Scenario: Signed in user visit homepage
    Given I am signed in
    When I visit the homepage
    Then I should not see sign_up sign_in links
    And  I should see sign_out settings links
