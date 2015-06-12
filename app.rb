require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'yaml'

def msg(str)
	if str == nil || str.strip == ""
		suggestions = YAML.load_file("search_ideas.yml")
		str = suggestions.sample
		msg(str)
	else
		new_str = str.gsub(' ', '%20')
		base = "https://www.google.com/search?q="
		search_results = base << new_str
	end
end

get '/' do
	str = params['Body'].downcase
	puts msg(str)

	twiml = Twilio::TwiML::Response.new do |r|
		r.Message msg(str)
	end
	twiml.text
end