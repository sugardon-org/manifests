#!/usr/bin/env bash

# update sugardonblog tag
#
# variables
#
# GitHub Personal Access Token
# $ export GITHUB_AUTH_TOKEN="YOUR_TOKEN"
# GitHub REV and TAG
# $ export REV="YUOR_TAG"
#
# helm values file
VALUES_FILE="applications/sugardonblog/values.yaml"
# Github Repository
ORG="sugardon-org"
REPO="manifests"
BRANCH="update-tag-$REV"

set -eux

# requirements
yq --version
gh --version

# login
echo -n "$GITHUB_AUTH_TOKEN" | gh auth login --with-token

# working directory
mkdir -p "./github.com/sugardon-org/manifests/$REV" && cd $_ || exit 1
gh repo clone "$ORG/$REPO"
cd $REPO

# update tag
yq -i '.nextjs.image.tag="'$REV'"' $(pwd)/$VALUES_FILE

# branch
git switch -c $BRANCH
# commit
git add .
git -c user.name="sugardon" \
    -c user.email="sugardon@sugardon.com" \
    -c commit.gpgsign=false \
    commit -m "Update tag $REV"
# push
git config credential.helper ""
git config credential.helper store
echo "https://x-access-token:$GITHUB_AUTH_TOKEN@github.com" >> ~/.git-credentials
git push -u origin $BRANCH -f
# pull request
gh pr create \
    --repo="$ORG/$REPO" \
    --head="$BRANCH" \
    --base="main" \
    --title="Update tag $REV" \
    --body="Update tag $REV" \
    --label="automerge"
