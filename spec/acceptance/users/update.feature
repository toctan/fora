Feature: Update user profile

  As a user
  I want to update information about myself

  Background:
    Given I am signed in
    And I am on settings page

  Scenario: Update username without password
    When I update username without password
    Then I should see 'You updated your account successfully.' message

  Scenario: Update password without password
    When I update password without password
    Then I should see 'we need your current password' helper block

  Scenario: Update password with password
    When I update password with password
    Then I should see 'You updated your account successfully' message
