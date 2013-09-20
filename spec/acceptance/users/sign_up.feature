Feature: Sign up

  As a visitor
  I want to sign up
  So that I can post some comments or new threads

  Background:
    Given I am not signed in

  Scenario: User signs up with valid data
    When I sign up with valid data
    And  I should see confirmation email message
    When I click the confirmation link
    Then I should see account confirmed message