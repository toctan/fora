Feature: Change avatar

  In order to look more fancy
  As a user
  I want change my avatar

  Background:
    Given I am signed in
    And I am on settings page

  Scenario: User upload valid image
    When I upload a valid image
    Then I should see 'You updated your account successfully.' message

  Scenario: User upload invalid image
    When I upload a huge image
    Then I should see "must less than 500KB" helper hint

  Scenario: User upload illegal file
    When I upload an illegal image
    Then I should see "is invalid" helper hint
