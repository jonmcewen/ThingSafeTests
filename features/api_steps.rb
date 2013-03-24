Transform /^(-?\d+)$/ do |number|
  number.to_i
end

def decode_api_response_as(model_name, format)
  if format == 'JSON'
    decoded = ActiveSupport::JSON.decode(response.body)
    if decoded.is_a?(Array)
      decoded.map { |inst| inst[model_name] }
    else
      decoded[model_name]
    end
  elsif format == 'XML'
    decoded = Hash.from_xml(response.body)
    decoded[model_name] || decoded[model_name.pluralize]
  else
    raise "Unsopported response format: #{format}"
  end
end

def backdoor_get (path)
  backdoor_auth
  get(path)
end

def get(path)
  page.driver.header('Accept',       "application/json")
  visit(path)
end

def backdoor_auth
  page.driver.header('oauth_token',       "letmein")
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
#  pending # express the regexp above with the code you wish you had
end
