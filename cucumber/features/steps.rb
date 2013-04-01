require "json_spec/cucumber"

thing_url = 'http://localhost:8080/mythings/'

Transform /^(-?\d+)$/ do |number|
  number.to_i
end

def backdoor_get (path)
  backdoor_auth
  get(path)
end

def get(path)
  page.driver.header('Accept', "application/json")
  visit(path)
end

def backdoor_auth
  page.driver.header('Authorization', 'OAuth oauth_token="letmein"')
end

Given /^that ThingSafe is up$/ do
  # It had better be!
end

When /^I GET "(.*?)"$/ do |path|
  backdoor_get(path)
end

When /^I GET "(.*?)" with an invalid token$/ do |path|
  visit(path)
end

When /^I GET "(.*?)" with a valid token$/ do |path|
  backdoor_get(path)
end

Then /^I should see the following results$/ do |table|
  # table is a Cucumber::Ast::Table
  expected = ''
  table.hashes.each do |row|
    expected << '* ' << row['check'] << ': ' << row['result'] << ' '
  end
  page.should have_content(expected)
end

Then /^the response code should be (\d+)$/ do |response_code|
  page.status_code.should == response_code
end

Then /^the "([^\"]*)" header should be "(.*)"$/ do |key, value|
  page.status_code.should == 444
end

Given /^I have a valid OAth token$/ do
  page.driver.header('Auth', "mytoken")
end

