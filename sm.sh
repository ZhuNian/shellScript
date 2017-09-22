#!/bin/bash
set -e
# set -x
if [[ $1 != 'publish' && $1 != 'update' ]]; then
  echo "Oops, publish or update the sm-sheet"
  exit 1
fi

file="./package.json"
version="$(npm show @shimo/sm-sheet version)"
function increaseVersion {
  if [[ $version =~ ([0-9]+.)([0-9]+.)([0-9]+) ]]; then
    nextVersion="${BASH_REMATCH[1]}${BASH_REMATCH[2]}$((${BASH_REMATCH[3]} + 1))"
  fi
}

if [[ $1 == 'publish' ]]; then
  increaseVersion
  # sed -i '' "3s/.*/  \"version\": \"${nextVersion}\",/" $file && npm run build && git add . && git commit -m"update sm-sheet to $nextVersion" || echo 'oops, publish sm-sheet failed'
  sed -i '' "3s/.*/  \"version\": \"${nextVersion}\",/" $file && npm publish  && git add . && git commit -m"update sm-sheet to $nextVersion" && git push  || echo 'oops, publish sm-sheet failed'
fi

if [[ $1 == 'update' ]]; then
 sed -i '' "s/\"@shimo\/sm-sheet\": \".*\"/\"@shimo\/sm-sheet\": \"${version}\"/" $file && npm install && git add . && git commit -m"update sm-sheet to $version"  || echo 'oops, update sm-sheet failed' 
fi
