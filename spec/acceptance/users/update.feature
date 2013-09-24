Feature: Update

  I want to update information about myself

  Background:
    Given I am signed in
    And I am on update page

  Scenario: username without password
    When I update username without password
    Then I should see 'You updated your account successfully.' message

  Scenario: password without password
    When I update password without password
    Then I should see 'we need your current password to confirm your changes' helper block

  Scenario: email without password
    When I update email without password
    Then I should see 'we need your current password to confirm your changes' helper block

  Scenario: password with password
    When I update password with password
    Then I should see 'You updated your account successfully' message
