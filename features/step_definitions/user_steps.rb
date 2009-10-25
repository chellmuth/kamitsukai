Given /^the following users:$/ do |users|
  User.make(users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(table_at('table').to_a)
end

Given /^I have an account "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  @user_plan = User.plan(
    :username => username,
    :password => password
  )
  @user = User.create(@user_plan)
end

Given /^I am logged in to account "([^\"]*)"$/ do |username|
  @user_plan = User.plan(:username => username)
  @user = User.create(@user_plan)
  visit '/login'
  fill_in('username', :with => username)
  fill_in('password', :with => @user_plan[:password])
  click_button('Login')
  within('#user_nav') do |content|
    content.should contain('Logout')
    content.should_not contain('Login')
  end
end
