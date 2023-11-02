#!/bin/bash

set +e

SSH_KEY_DIRECTORY="/opt/keys"
export PATH=/strong/bin:$PATH

# Run a ssh agent
eval "$(ssh-agent -s)"

# Add the ssh key
ssh-add "$SSH_KEY_DIRECTORY/ssh_key" || echo "ignore ssh for local deployment"


# Run IDE
/strong/bin/strongcli setup 11111