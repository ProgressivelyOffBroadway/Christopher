require 'sinatra'
require 'json'

# Main payload for the time being
post '/payload' do

  # Parse the json
  json = JSON.parse( request.body.read )
  # Query for the URL of the repo that sent the webhook
  repo_url =  json["repository"]["html_url"]
  # Clone the repository into a subdirectory
  system "git clone #{repo_url}"
  
end
