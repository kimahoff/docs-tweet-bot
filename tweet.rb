require 'rubygems'
require 'oauth'
require 'json'

consumer_key = OAuth::Consumer.new(
  'UzC20pPb1ryTjXMHxzo7YTC1D',
  'qOGT560RqzpWrCKEqaURCFx9qD42Fkhk8PXnfSMieBp4BsDIoH')
access_token = OAuth::Token.new(
  '2511086658-sUCKVUmFPy5S1oPX0vXffsY9qdHfmC8QTWI918e',
  'KYLIIS18B4PeeGEPCdQYP7DmxYAiR26Y8lOUPVsvTJ3gD')

  f = File.open("linklist.txt")
  contentsArray=[]  # start with an empty array
    f.each_line {|line|
      contentsArray.push line
    }
status = contentsArray.sample

baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/update.json"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data(
  "status" => status,
)

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER


# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
  puts "Successfully sent #{tweet["text"]}"
else
  puts "Could not send the Tweet! " +
  "Code:#{response.code} Body:#{response.body}"
end