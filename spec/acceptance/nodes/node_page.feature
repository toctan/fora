Feature: Node page
  As a user
  I want see all the topics under a node
  So that I can get information about a particular stuff

  Background:
    Given there exists a 'movie' node with a dozen of topics

  Scenario: User visit a existed node page
    When I visit '/go/movie'
    Then I should see all these topics 
