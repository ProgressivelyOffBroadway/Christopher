require 'sinatra'
require 'json'

# This is just the current primary payload
post '/payload' do

  # Parse the JSON sent from github
  json = JSON.parse( request.body.read )
  #Query the JSON for the url of the repository that sent the webhook
  repo_url =  json["repository"]["html_url"]

  # Clone the webhook into a directory
  system "git clone #{repo_url}"
  
end
