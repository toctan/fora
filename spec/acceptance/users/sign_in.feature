Feature: Sign in

  As a customer
  I want to sign in

  Background:
    Given I visit sign in page

  Scenario: User sign in with invalid data
    When I sign in with invalid data
    Then I should see flash error message

  Scenario: User sign in with email
    When I sign in with email
    Then I should see flash success message

  Scenario: User sign in with username
    When I sign in with username
    Then I should see flash success message