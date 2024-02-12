#!/bin/bash

# Function to retrieve the IP address of multipass VM
ipAddress() {
    # First arg needs to be a name
    name=$1

    multipass info --format json $name | jq -r '.info | to_entries[] | .value.ipv4[0]'
}