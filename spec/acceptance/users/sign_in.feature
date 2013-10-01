Feature: Sign in

  As a customer
  I want to sign in

  Background:
    Given I am a signed up user
    And I am on sign_in page

  Scenario: User sign in with invalid data
    When I sign in with invalid
    Then I should see 'Invalid login or password' message

  Scenario: User sign in with email
    When I sign in with email
    Then I should see 'Signed in successfully' message

  Scenario: User sign in with username
    When I sign in with username
    Then I should see 'Signed in successfully' message
