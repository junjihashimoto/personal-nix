#!/usr/bin/env bash
set -x

if [ $# -ne  $1] ; then
    echo "Usage: gh-commit.sh owner/repo < message" 1>&2
    exit 1
fi

repo="$1"

COMMIT=`git rev-parse HEAD`
#gh api "repos/{owner}/{repo}/commits/$COMMIT/comments" -f body=$<(/dev/stdin)
echo -e "\`\`\`\n" > /tmp/msg
cat | col -b >> /tmp/msg
echo -e "\n\`\`\`" >> /tmp/msg
export msg=$(cat /tmp/msg)
gh api "repos/${repo}/commits/${COMMIT}/comments" -f body="${msg}"
