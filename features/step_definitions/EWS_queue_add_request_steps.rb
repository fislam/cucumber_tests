require 'httparty'
require 'rspec-expectations'
require 'json'
require 'pg'

USER_ID = '0dc460b6-ff79-4bbc-9f34-7666093eb165'
DB_INFO = {
    :ip => '192.168.59.103',
    :port => 5432,
    :user_name => 'idgtool',
    :password => 'idgtoolPassword'
}
request_activation_response = ''

Given(/^the customer is currently not installed in EWS$/) do
  tool_accounts_response = HTTParty.get('http://localhost:8080/tool_accounts/',
    :headers => {'PN-Authorization' => USER_ID})
  tool_accounts_response.length.should eq(0)
end

Given(/^an add request is currently not in flight awaiting a response from the vendor$/) do
  status = ''

  connection = PGconn.connect(DB_INFO[:ip], DB_INFO[:port], nil, nil, nil, DB_INFO[:user_name], DB_INFO[:password])
  tool_account_result = connection.exec("select * from tool_account where user_id='#{USER_ID}' AND tool_id='EWS'")
  tool_account_id = tool_account_result[0]['id']
  account_request_result = connection.exec("select status from account_request where tool_account_id='#{tool_account_id}'")

  account_request_result.each do |row|
    status = row['status']
  end

  status.downcase.should eq('queued')
  connection.close
end

When(/^subscriber has requested an activation of "([^"]*)" tool$/) do |tool|
  request_activation_response = HTTParty.post("http://localhost:8080/tool_accounts/#{tool}",
    :headers => {'PN-Authorization' => USER_ID,
                 'Content-type' => 'application/json'})
end

Then(/^I should queue an add request$/) do
  request_activation_response['active'].should eq(false)
  request_activation_response['pendingActive'].should eq(true)
end
