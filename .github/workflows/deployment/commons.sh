#!/usr/bin/env bash

export repo_root_dir=$(git rev-parse --show-toplevel)
export site_src="${repo_root_dir}/_site"
export gh_pages_dir="${repo_root_dir}/docs"
export deployments_dir="${gh_pages_dir}/branches"

# Site built from the main branch will be available at 'https://<domain_name>/'.
# Sites built from other branchs will be available at 'https://<domain_name>/branches/<branch_name>'.
export main_git_branch="hakyll"

# replace "/", "#", etc with "-".
slugify() {
  echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+/-/g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$/-/g' | tr A-Z a-z
}
export -f slugify

git config user.name github-actions
git config user.email github-actions@github.com

update_deployments_list() {
  github_project_url=$(git remote get-url origin)
  if [[ $github_project_url == git@github.com:* ]]; then
    github_repo=$(echo ${github_project_url#"git@github.com:"} | sed 's/\.git$//g')
  elif [[ $github_project_url == https://github.com/* ]]; then
    github_repo=$(echo ${github_project_url#"https://github.com/"} | sed 's/\.git$//g' | sed 's/^\/\///g')
  fi

  github_repo_owner=$(echo "${github_repo}" | sed 's/\/.*$//g')
  github_repo_name=$(echo "${github_repo}" | sed 's/^.*\///g')

  deployments_list="DEPLOYMENTS.md"
  echo "Updating ${deployments_list}"
  rm $deployments_list

  # Create a markdown table
  touch $deployments_list
  echo "# Deployments" >>$deployments_list
  echo "" >>$deployments_list
  echo "| Branch | Link |" >>$deployments_list
  echo "| --- | --- |" >>$deployments_list

  main_deployment_url="https://${github_repo_owner}.github.io/${github_repo_name}/"
  echo "| [${main_git_branch}](https://github.com/${github_repo_owner}/${github_repo_name}/tree/${branch}) | [Open](${main_deployment_url}) |" >>$deployments_list

  remote_branches=$(git ls-remote --heads origin | sed 's?.*refs/heads/??' | grep -v "gh-pages" | grep -v "${main_git_branch}")
  echo "$remote_branches" | while IFS= read -r branch; do
    branch_slug=$(slugify $branch)
    deployment_url="https://${github_repo_owner}.github.io/${github_repo_name}/branches/${branch_slug}"
    echo "| [${branch}](https://github.com/${github_repo_owner}/${github_repo_name}/tree/${branch}) | [Open](${deployment_url}) |" >>$deployments_list
  done

  # Update gh-pages branch
  git add --all
  git commit --allow-empty -m "Update ${deployments_list} [ci skip]"
  git push --force origin gh-pages
}

export -f update_deployments_list
