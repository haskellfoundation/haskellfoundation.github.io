#!/usr/bin/env bash

# Remove deployment by specified git branch name.

set -eo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $script_dir/commons.sh

git checkout gh-pages
git pull origin gh-pages

branch_slug=$(slugify $1)
rm -rf "$deployments_dir/$branch_slug"

echo "Updating gh-pages branch."
git add --all
git commit --allow-empty -m "Delete '$1' branch deployment [ci skip]"
git push --force origin gh-pages
echo "Deployment for branch '$1' has been deleted."

update_deployments_list
