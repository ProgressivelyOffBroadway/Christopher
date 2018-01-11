require 'sinatra'
require 'json'
  
get '/' do
  "Hello world!"
end

get '/push' do
  "Hey Hoyle!"
end

### Design Considerations ###
#
### Querying data arrays
## Description: Querying the data from stripped JSON files
#
# We will be using symbols for array indexing as a way to increase readability
#
# Symbols:
#
# Repo URL -- :repo_url
# Username -- :user_name
# User email -- :user_email
# Push Commit message -- :message



### Function Declarations
# Strip a Gitlab API payload
def gitlab_strip( body )
  json_rep = JSON.parse( body.read )

  # Get commit count for indexing purposes
  count = json_rep["total_commits_count"]
  
  data = {
    :repo_url => json_rep["repository"]["git_http_url"],
    :user_name => json_rep["user_name"],
    :user_email => json_rep["user_email"],
    :message => json_rep["commits"][count - 1]["message"]
  }
  
  # Return the data
  return data
  
end

# Strip a Github API payload
def github_strip( body )
  json_rep = JSON.parse( body.read )

  # Isolate owner data for readability
  owner = json_rep["repository"]["owner"]

  data = {
    :repo_url => json_rep["repository"]["html_url"],
    :user_name => owner["name"],
    :user_email => owner["email"],
    :message => json_rep["head_commit"]["message"]
  }
  
  # Return the data
  return data
end

# Designate the API and return an array containing important information
# TODO: find a more elegant way to deal with this issue of differentiation
def designated_API( request )

  # Check whether the header passed in is a gitlab or github header
  gitlab_status = request.env["HTTP_X_GITLAB_EVENT"]
  github_status = request.env["HTTP_X_GITHUB_EVENT"]
  
  # If the head is gitlab then call the gitlab API strip function
  if gitlab_status == "Push Hook"
    return gitlab_strip( request.body )
    
  # If the head is github then call the github API strip function
  elsif github_status == "push"
    return github_strip( request.body )

  # Otherwise return an empty array 
  else
    return []

  end

end


# Main payload for the time being
post '/push' do
  
  data = designated_API( request )
    
  # Initialize a new subdirectory with the scraped username 
  system "git clone \"#{data[:repo_url]}\" \"subdir-#{data[:user_name]}\""
 
  
end

