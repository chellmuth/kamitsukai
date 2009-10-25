@https://www.pivotaltracker.com/story/show/1559138
Feature: Users can login and logout
  In order to use their account
  a registered user
  wants to be able to login and logout

  Scenario: Login the user
   Given I have an account "foo" with password "bar baz"
   And I am on the login page
   When I fill in "Username" with "foo"
   And I fill in "Password" with "bar baz"
   And I press "Login"
   Then I should see "Logout" within "#user_nav"
   And I should see "foo" within "#user_nav"
   And I should not see "Register" within "#user_nav"

  Scenario: Logout the user
   Given I am logged in to account "foo"
   When I follow "Logout"
   Then I should see "Register" within "#user_nav"
   And I should see "Login" within "#user_nav"
   And I should not see "foo" within "#user_nav"
   And I should not see "Logout" within "#user_nav"
