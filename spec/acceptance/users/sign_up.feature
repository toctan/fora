Feature: Sign up

  As a visitor
  I want to sign up
  So that I can post some comments or new threads

  Background:
    Given I am not signed in

  Scenario: User signs up with valid data
    When I sign up with valid data
    Then I should see 'A message with a confirmation' message
    When I click the confirmation link
    Then I should see 'successfully confirmed' message
