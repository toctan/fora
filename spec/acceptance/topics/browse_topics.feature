Feature: Browse Topics

  As a user
  I want to browse topics
  So that I can get some information

  Scenario: Browse topics on homepage
    Given there exists a bunch of topics
    When I visit the homepage
    Then I should only see the first 20 topics
    When I click on one topic's title
    Then I should see the topic's content
