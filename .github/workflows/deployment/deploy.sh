#!/usr/bin/env bash

# Deploy static site to the GitHub pages.

set -eo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $script_dir/commons.sh

deploy() {
  if [[ ! -z "$GITHUB_REF_NAME" ]]; then
    # The GITHUB_REF_NAME env variable is available in github actions.
    git_branch=$GITHUB_REF_NAME
  else
    git_branch=$(git branch --show-current)
  fi
  echo "Current git branch is '${git_branch}'."

  git checkout gh-pages
  git pull origin gh-pages

  if [ "$git_branch" == "$main_git_branch" ]; then
    site_dest="${gh_pages_dir}"

    # Create temporary backup for other branches content.
    mv "${deployments_dir}" .

    # Replace site files.
    rm -rf "${site_dest}"
    mkdir -p "${site_dest}"
    cp -a -v ${site_src}/* ${site_dest}/

    # Restore temporary backup for other branches content.
    mv ./branches "${gh_pages_dir}/"
  else
    # Patch html files to tell search engine bots like google-bot not to index this content.
    # More info: https://developers.google.com/search/docs/advanced/crawling/block-indexing
    find $site_src -name '*.html' -exec sed -i 's/<head>/<head><meta name="robots" content="noindex, nofollow">/g' {} \;

    branch_slug=$(slugify $git_branch)
    site_dest="${gh_pages_dir}/branches/${branch_slug}"

    # Replace site files.
    rm -rf "${site_dest}"
    mkdir -p "${site_dest}"
    cp -a -v ${site_src}/* ${site_dest}/
  fi

  echo "Updating gh-pages branch."
  git add --all
  git commit --allow-empty -m "Update '${git_branch}' branch deployment [ci skip]"
  git push --force origin gh-pages
  echo "Deployment finished."
}

deploy
update_deployments_list
