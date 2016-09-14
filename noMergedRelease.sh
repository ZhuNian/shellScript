#!/bin/bash
username=$1;
echo "branches not merged into origin/release $username"

getNoMergedBranch () {
 git fetch -p origin
 for branch in `git branch -r --no-merged origin/release `; do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch;      done | sort -r
} 

if [ $username ]; then
  getNoMergedBranch |grep $username
else
   getNoMergedBranch
fi  
