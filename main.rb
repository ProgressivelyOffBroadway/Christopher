require 'sinatra'
require 'json'

# Main payload for the time being
post '/payload' do

  # Parse the json
  json = JSON.parse( request.body.read )
  # Query for the URL of the repo that sent the webhook
  repo_url =  json["repository"]["html_url"]
  # Query for the username that sent the webhook
  username = json["repository"]["owner"]["login"]
  # Clone the repository into a subdirectory
  #system "git clone #{repo_url}"
  # Initialize a new subdirectory with the scraped username 
  system "git clone subdir-#{username}"
  
end
