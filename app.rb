require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'json'
require 'rest-client'

account_sid = ENV['MY_SEKRET_TWILIO_KEY']
auth_token = ENV['MY_SEKRET_TWILIO_TOKEN']

# puts account_sid
# puts auth_token

# url = RestClient.get 'https://api.twilio.com/2010-04-01/Accounts/' + account_sid.to_s + '/Messages.json',
# 	{:Authorization => account_sid auth_token}
# # url = RestClient.get "https://#{account_sid}:#{auth_token}@api.twilio.com/2010-04-01/Accounts/#{account_sid}/Messages.json"
# json_blob = JSON.generate(url)
# puts json_blob["from"]


get '/' do 
	# print params
	# twiml = Twilio::TwiML::Response.new do |r|
	# 	r.Message "I am replying to you!"
	# end
	# twiml.text
	params
end