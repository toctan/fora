Feature: Browse replies

  As a user
  I want to browse replies
  So that I can get some information

  Scenario: Browse replies for a topic
    Given there exists a bunch of replies of a topic
    When I visit the topic
    Then I should only see the first 20 replies
