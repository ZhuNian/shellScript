#!/bin/bash
set -e

REDCOL='\e[31m'
BLUECOL='\e[34m'
ENDCOL='\e[0m'

read -p "please input the project id" project
project=${project:-102}

read -p "please input the source branch>> " sourceBranch

read -p "please input the target branch>> " targetBranch
targetBranch=${targetBranch:-test}

read -p "please input the title of your merge request>> " title
title=${title:-test merge request}

read -p "please input the desc of your merge reques>> " desc
desc=${desc:-test merge request}

read -p "please input the label of your request" label
label=${label:-feature}
labels=();
labels+=(${label})

echo -e "creating merge request:
sourceBranch: ${BLUECOL}$sourceBranch${ENDCOL}
targetBranch: ${BLUECOL}$targetBranch${ENDCOL}
title: ${BLUECOL}$title${ENDCOL} 
desc: ${BLUECOL}$desc${ENDCOL}
labels: ${BLUECOL}$labels${ENDCOL}"

curl --header "PRIVATE-TOKEN: fwUBmDfesQGZQCxzvpUR" --data "source_branch=$sourceBranch&target_branch=$targetBranch&assignee_id=58&title=$title&description=$desc&labels=$labels" "http://gitlab.qtang.net/api/v3//projects/$project/merge_requests" 
