require 'httparty'
require 'json'
require 'rspec-expectations'
require 'json-schema'
require_relative '../../test_data/data'
require_relative '../../test_data/bad-data'
require_relative '../../test_data/schema/json-schema'

response = ''
bad_response = ''

Given /^I create a PIPPA alert with valid JSON data$/  do
  response = HTTParty.post('http://localhost:8080/tools/pippa/alerts/webhook',
      :body => test_data.to_json,
      :headers => {'Authorization' => 'Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==',
                   'Content-Type' => 'application/json'})
end

Then /^I should get a valid response$/ do
  response.code.should eq(200)
  response['transaction']['id'].should eq(test_data['transaction']['id'])
  response['status']['code'].should eq('0001')
  response['status']['message'].downcase.should eq('success')
end

Then /^a valid JSON schema$/ do
  JSON::Validator.validate(json_schema, JSON.parse(response.body))
end

When /^I create a PIPPA alert with bad data in the JSON/ do
  bad_response = HTTParty.post('http://localhost:8080/tools/pippa/alerts/webhook',
      :body => bad_test_data.to_json,
      :headers => {'Authorization' => 'Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==',
                   'Content-Type' => 'application/json'})
end

Then /^I should get a "(.*)" http status code$/ do |status_code|
  bad_response.code.should eq(status_code.to_i)
end

Then /^an error message in the response$/ do
  error_message = 'Property [\'city\'] not found in path $[\'client\'][\'contact\'][\'address\']'
  bad_response['transaction']['id'].should eq(nil)
  bad_response['status']['code'].should eq('0003')
  bad_response['status']['message'].downcase.should eq(error_message.downcase)
end
