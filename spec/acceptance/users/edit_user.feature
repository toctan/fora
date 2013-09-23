Feature: Edit user

  I want Edit my settings

  Background:
    Given I am signed in
    And I am on edit page

  Scenario: User upload valid image
    When I upload with valid image
    Then I should see 'You updated your account successfully.' message

  Scenario: User upload invalid image
    When I upload with huge image
    Then I should see "must less than 500KB" helper hint

  Scenario: User upload illegal file
    When I upload with illegal image
    Then I should see "is invalid" helper hint