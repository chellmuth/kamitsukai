@http://www.pivotaltracker.com/story/show/1559115
Feature: User registration
  In order to have extra features on the site
  As a new visitor
  I want to be able to register an account

  Scenario: Register new user
    Given I am on the new user page
    When I fill in "Username" with "username 1"
    And I fill in "Email" with "my_email@example.com"
    And I fill in "Password" with "password 1"
    And I fill in "Password confirmation" with "password 1"
    And I press "Submit"
    Then I should see "Logout" within "#user_nav"
    And I should not see "Register" within "#user_nav"
    And I should see "username 1" within "#user_nav"
