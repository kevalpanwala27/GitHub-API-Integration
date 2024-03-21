#!/bin/zsh

#############################
# Author: Keval Panwala
#
# Date: 15th Feb 2024
#
# Version: v1
#############################

# First git clone is done - git clone url of that repository ....
# after this we have to do this in our terminal.
# export username="kevalpanwala27"
# export token="github token of your account"


# then after ....


# Example ./list-users.sh devops-by-examples (REPO_OWNER) python (REPO_NAME)


############## Here is the script ################


helper() # here we are calling the function...

# Function to make a GET request to the GitHub API
function github_api_get {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"

	# Send a GET request to the GitHub API with authentication
	curl -s -u "${USERNAME}:${TOKEN}" "$url"
}


# Function to list users with read access to the repository
function list_users_with_read_access {
	local endpoint="repo/${REPO_OWNER}/${REPO_NAME}/collaborators"

	# Fetch the list of collaborators on the repository
	collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

	# Display the list of collaborators with read access
	if [[ -z "$collaborators" ]]; then
		echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}:"
		echo "$collaborators"
	fi
}

function helper {
	expected_cmd_args=2
	if [ $# -ne $expected_cmd_args]; then
		echo "please execute the script with required cmd args"
		echo "asd"
}


# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access



