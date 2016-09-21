#!/bin/bash
echo 'check branches both merged into test and release branch'

if [ $1 ]; then
  echo "for user $1"
fi

userName=$1

function getMergedBranches() {
  git fetch -p origin
 
  mergedRelease=$( git branch -r --merged origin/release )
  mergedTest=$( git branch -r --merged origin/test )
  result=();

  for branch in $mergedRelease; do 
    flag=0

    for branchTest in $mergedTest; do
     if [ ${branchTest} == ${branch} ]; then
      flag=1
      break
     fi
    done

    if [ $flag == 1 ]; then
      result+=(${branch});
    fi

  done


  for branch in ${result[@]}; do
    echo -e `git show --format="%ai %ar by %an" $branch | head -n 1`\\t$branch;
  done | sort -r
}

if [ $userName ]; then
  getMergedBranches | grep "$userName"
else
  getMergedBranches
fi
