#!/bin/bash
set -x
set -e

DST="/home/nian/Documents/work"
SRC="/home/nian/Documents/work/titan-web-frontend"

msg="$(cd $SRC && git checkout dev >> /dev/null && git pull >> /dev/null && grunt build >> /dev/null && git log -1 --pretty=%B)"

$(cd $DST && rm -rf $DST/titan-web-beta && git clone ssh://root@172.16.6.121:/gits/titan-web titan-web-beta && cd titan-web-beta/frontend/public/ && rm -rf `ls  | grep -v 'index.php'` && cp -r $SRC/rel/* ./ && git add . && git commit -m"${msg}" && git push && rm -rf $DST/titan-web-beta || exit 1)


# $(cd $DST && rm -rf $DST/titan-web-beta && git clone ssh://root@172.16.6.121:/gits/titan-web titan-web-beta && cd titan-web-beta/frontend/public/ && rm -rf `ls  | grep -v 'index.php'` && cp -r $SRC/rel/* ./ && git add . && git commit -m"${msg}" && echo 'yes' && rm -rf $DST/titan-web-beta || exit 1)
