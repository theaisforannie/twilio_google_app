require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/' do 
	twiml = Twilio::TwiML::Response.new do |r|
		r.Message "I am replying to you!"
	end
	twiml.text
end