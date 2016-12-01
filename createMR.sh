#!/bin/bash
set -e

REDCOL='\e[31m'
BLUECOL='\e[34m'
ENDCOL='\e[0m'

read -p "please input the project name>> " projectName
project=$(curl --header "PRIVATE-TOKEN: fwUBmDfesQGZQCxzvpUR" "http://gitlab.qtang.net/api/v3/projects/hangban%2F$projectName" -s | cut -d ',' -f1 | cut -d ':' -f2) 
project=${project:-102}

read -p "please input the source branch>> " sourceBranch
currentBranch=$(git branch | grep \* | cut -d ' ' -f2);
sourceBranch=${sourceBranch:-$currentBranch}

read -p "please input the target branch>> " targetBranch
targetBranch=${targetBranch:-test}

read -p "please input the title of your merge request>> " title
title=${title:-test merge request}

read -p "please input the desc of your merge reques>> " desc
lastCommit=$(git log -1 --pretty=%B)
desc=${desc:-$lastCommit}

read -p "please input the label of your request" label
label=${label:-feature}
labels=();
labels+=(${label})

echo -e "creating merge request:
project: ${REDCOL}$project${ENDCOL}
projectName: ${BLUECOL}$projectName${ENDCOL}
sourceBranch: ${BLUECOL}$sourceBranch${ENDCOL}
targetBranch: ${BLUECOL}$targetBranch${ENDCOL}
title: ${BLUECOL}$title${ENDCOL} 
desc: ${BLUECOL}$desc${ENDCOL}
labels: ${BLUECOL}$labels${ENDCOL}"

curl --header "PRIVATE-TOKEN: fwUBmDfesQGZQCxzvpUR" --data "source_branch=$sourceBranch&target_branch=$targetBranch&assignee_id=58&title=$title&description=$desc&labels=$labels" "http://gitlab.qtang.net/api/v3//projects/$project/merge_requests" 
