#!/bin/bash
set -e

cd build
git init
git lfs track "*.zip"

git config user.name "Travis CI"
git config user.email "travis@travis-ci.org"

git add modpack.zip
git commit -m "Deploy ${TRAVIS_COMMIT}"

# We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_DEPLOY_KEY}@${GH_REF}" master:dist

echo 'Deployed on dist branch'
