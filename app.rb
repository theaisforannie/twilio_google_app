require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'yaml'
require 'pg'
require 'uri'

host = "localhost"
port = 5432
dbname = "test_db"
user = nil
password = nil
table_name = ENV['TABLE_NAME'] || "test_table"

if ENV['DATABASE_URL'] != nil
	uri = URI.parse(ENV['DATABASE_URL'])
	host = uri.hostname
	port = uri.port
	dbname = uri.path[1..-1]
	user = uri.user
	password = uri.password
	puts ":D"
end

conn = PG.connect(host, port, nil, nil, dbname, user, password)


def save_params(params)
	"INSERT INTO #{table_name} (
		accountsid,
		apiversion,
		body,
		\"From\",
		fromcity,
		fromcountry,
		fromstate,
		fromzip,
		messagesid,
		nummedia,
		smsmessagesid,
		smssid,
		smsstatus,
		\"To\",
		tocity,
		tocountry,
		tostate,
		tozip
		) VALUES (
		\'#{params["AccountSid"]}\',
		\'#{params["ApiVersion"]}\',
		\'#{params["Body"]}\',
		\'#{params["From"]}\',
		\'#{params["FromCity"]}\',
		\'#{params["FromCountry"]}\',
		\'#{params["FromState"]}\',
		\'#{params["FromZip"]}\',
		\'#{params["MessageSid"]}\',
		\'#{params["NumMedia"]}\',
		\'#{params["SmsMessageSid"]}\',
		\'#{params["SmsSid"]}\',
		\'#{params["SmsStatus"]}\',
		\'#{params["To"]}\',
		\'#{params["ToCity"]}\',
		\'#{params["ToCountry"]}\',
		\'#{params["ToState"]}\',
		\'#{params["ToZip"]}\'
		);"
end	

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
	conn.exec save_params(params)
	str = params['Body'].downcase
	
	puts msg(str)

	twiml = Twilio::TwiML::Response.new do |r|
		r.Message msg(str)
	end
	twiml.text
end