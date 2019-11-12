#!/bin/sh -l

set -e

REPOSITORY_PATH="https://x-access-token:${GITHUB_TOKEN}@github.com/${BLOG_REPOSITORY}.git"

echo "REPOSITORY_PATH：${REPOSITORY_PATH}"

# Installs Git and jq.
apt-get update && \
apt-get install -y git && \

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE 

echo "npm install ..." 
npm install

echo "Clean folder ..."
./node_modules/hexo/bin/hexo clean

echo "Sync yuque ..."
./node_modules/.bin/yuque-hexo sync

echo "Generate file ..."
./node_modules/hexo/bin/hexo generate

cd $PUBLISH_DIR
echo "Config git ..."

git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git remote add origin "${REPOSITORY_PATH}"

git checkout --orphan $BRANCH

git add --all

echo 'Start Commit'
git commit --allow-empty -m "Deploying to ${BRANCH}"

echo 'Start Push'
git push origin "${BRANCH}" --force

echo "Deployment succesful!"
