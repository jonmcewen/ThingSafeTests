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

Given /^that ThingSafe is up$/ do
  # It had better be!
end

When /^I GET "(.*?)"$/ do |path|
  page.driver.header('Accept',       "application/json")
  visit(path)
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
  #page.response_code.should == response_code.to_i
end

Then /^the "([^\"]*)" header should be "(.*)"$/ do |key, value|
  #page.response.headers[key].should == value
end

Given /^I have a valid OAth token$/ do
  page.driver.header('Auth', "mytoken")
#  pending # express the regexp above with the code you wish you had
end
