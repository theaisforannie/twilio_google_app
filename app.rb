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
	str = params['Body']
	new_str = str.gsub(' ', '%20')
	base = "https://www.google.com/search?q="
	search_results = base << new_str

	puts search_results

	twiml = Twilio::TwiML::Response.new do |r|
		r.Message search_results
	end
	twiml.text

	# if f == nil || f.strip == ""
	# 	msg = "say something pls"
	# else
	# 	msg = f.strip + ' your face, I can write angle brackets too'
	# end

	# puts params
	# twiml = Twilio::TwiML::Response.new do |r|
	# 	r.Message msg
	# end
	# puts "twiml says: " + twiml.text
	

 #  'nope'
	# '<?xml version="1.0" encoding="UTF-8"?>
	# <Response>
	#     <Message>' + msg + '</Message>
	# </Response>'
end