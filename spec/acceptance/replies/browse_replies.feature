Feature: Browse replies

  As a user
  I want to browse replies
  So that I can get some information

  Scenario: Browse topics on a topic
    Given there exists a bunch of replies of a topic
    When I visit the topic
    Then I should see 20 replies paginated
