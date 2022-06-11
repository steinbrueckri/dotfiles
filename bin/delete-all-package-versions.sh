#!/bin/bash

# Script that works to delete private packages stored on Github Packages
#
# Script is based on the work of Troy Fontaine (github.com/troyfontaine)

GITHUB_TOKEN=$1
REPO_OWNER=$2
REPO_NAME=$3
PACKAGE_NAME=$4

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <TOKEN> <REPO_OWNER> <REPO_NAME> <PACKAGE_NAME>" >&2
  exit 1
fi

graphqlJson() {
  local query="$1"; shift
  curl -s -H "Authorization: bearer $GITHUB_TOKEN" -X POST -H "Accept: application/vnd.github.v3+json" -d '{"query":"'"$query"'"}' 'https://api.github.com/graphql'
}

graphqlDelete() {
    local query="$1"; shift

    curl -s -H "Accept: application/vnd.github.package-deletes-preview+json" -H "Authorization: bearer $GITHUB_TOKEN" -X POST -d '{"query":"'"$query"'"}' 'https://api.github.com/graphql'
}

deletePackageVersion() {
    PACKAGE_ID="$1"
    local query="$(cat <<EOF | sed 's/"/\\"/g' | tr '\n\r' '  '
mutation {
    deletePackageVersion(
      input:{packageVersionId:"$PACKAGE_ID"}
    )
    { success }
}

EOF
)"

  RESPONSE=$(graphqlDelete "$query")
  echo "$RESPONSE"
}

listPackageVersions() {

  local query="$(cat <<EOF | sed 's/"/\\"/g' | tr '\n\r' '  '
  query {
    repository(name: "$REPO_NAME", owner: "$REPO_OWNER") {
      id
      name
      registryPackages(first: 1,  name: "$PACKAGE_NAME") {
        nodes {
          versions(first: 100) {
            nodes {
              id
              version
            }
          }
          name
          id
        }
      }
    }
  }

EOF
)"

  ID_LIST=$(graphqlJson "$query" | jq -r '.data.repository.registryPackages.nodes[].versions.nodes[].id')
}

purgePackageVersions() {
  for ID in $ID_LIST
  do
    echo -e "Purging package version with ID: '$ID' ..."
    deletePackageVersion $ID;
  done
}

listPackageVersions
purgePackageVersions
