#!/bin/bash
# Copyright (c) HashiCorp, Inc.


typewriter() {
    delay=0.005
    string=$1
    len=${#string}

    for char in $(seq 0 $len); do
        printf "%c" "${string:$char:1}"
        sleep $delay
    done
    echo
}

ctab() {
  printf -- "$@%.0s" {1..50}
  printf "\n\n"
}

cyellow() {
    YELLOW='\033[0;33m'
    printf "${YELLOW}"
}

cnone() {
    NC='\033[0m'
    printf "${NC}"
}

clear
echo -e '\033[2K'

note="  Git uses a username to associate commits with an 
  identity. This is the target GitHub organization or 
  individual user account to manage.

  For instance, 

    Username: shiffman
    URL: https://github.com/shiffman

  We use this value to set the GITHUB_OWNER 
  environment variable."

cyellow
ctab "-"
typewriter "${note}"
cnone

# git_user=
# while [[ $git_user = "" ]]; do
  echo -e '\033[2K'
  read -p " Github Username: " git_user
  echo ""
# done

note="  A GitHub OAuth / Personal Access Token.

  We use this value to set the GITHUB_TOKEN 
  environment variable.
  
  Paste the string here. The value is not displayed."

cyellow
ctab "-"
typewriter "${note}"
cnone

echo -e '\033[2K'
read -s -p " Github Token: " git_token

echo ""
echo ""
note="  GitHub uses your commit email address to associate 
  commits with your account on GitHub.com."

cyellow
ctab "-"
typewriter "${note}"
cnone

echo -e '\033[2K'
read -p " User Email: " user_email
echo ""

if [ -z "$git_org" ]
then
  git_org=$git_user
fi

# These are runtime variables for the
# Terraform GitHub Repo. We express these
# to avoid having to reload the terminal

export GITHUB_TOKEN=$git_token
export GITHUB_OWNER=$git_user
export GITHUB_REPO="hashicat-app"

export USER_EMAIL="${user_email}"
export USER_NAME="${git_user}"

# Terraform variables for GitHub repo
# management. We're using these for the
# Terraform GitHub organization code

if grep -wq "GITHUB_OWNER" "/root/.bashrc"; then
  sed -i -r "s|(export GITHUB_OWNER=)(.+)?$|\1$GITHUB_OWNER|g" /root/.bashrc
else
  echo "export GITHUB_OWNER=${GITHUB_OWNER}" >> /root/.bashrc
fi

if grep -wq "GITHUB_TOKEN" "/root/.bashrc"; then
  sed -i -r "s|(export GITHUB_TOKEN=)(.+)?$|\1$GITHUB_TOKEN|g" /root/.bashrc
else
  echo "export GITHUB_TOKEN=${GITHUB_TOKEN}" >> /root/.bashrc
fi

if grep -wq "GITHUB_REPO" "/root/.bashrc"; then
  sed -i -r "s|(export GITHUB_REPO=)(.+)?$|\1$GITHUB_REPO|g" /root/.bashrc
else
  echo "export GITHUB_REPO=${GITHUB_REPO}" >> /root/.bashrc
fi

# Terraform variables for VCS connection.
# We're using these for the Terraform 
# Cloud workspace and PMR Module. 
# More explicitly, we use these when we:
#
# 1. link the VCS connection, and
# 2. load the PMR module from GitHub

export TF_VAR_github_owner=$GITHUB_OWNER
export TF_VAR_github_token=$GITHUB_TOKEN
export TF_VAR_github_repo=$GITHUB_REPO

if grep -wq "TF_VAR_github_owner" "/root/.bashrc"; then
  sed -i -r "s|(export TF_VAR_github_owner=)(.+)?$|\1$GITHUB_OWNER|g" /root/.bashrc
else
  echo "export TF_VAR_github_owner=${GITHUB_OWNER}" >> /root/.bashrc
fi

if grep -wq "TF_VAR_github_token" "/root/.bashrc"; then
  sed -i -r "s|(export TF_VAR_github_token=)(.+)?$|\1$GITHUB_TOKEN|g" /root/.bashrc
else
  echo "export TF_VAR_github_token=${GITHUB_TOKEN}" >> /root/.bashrc
fi

if grep -wq "TF_VAR_github_repo" "/root/.bashrc"; then
  sed -i -r "s|(export TF_VAR_github_repo=)(.+)?$|\1$GITHUB_REPO|g" /root/.bashrc
else
  echo "export TF_VAR_github_repo=${GITHUB_REPO}" >> /root/.bashrc
fi

echo -e '\033[2K'

note=" Thank you. We will use the following information locally:

    Username:     ${GITHUB_OWNER}
    URL:          https://github.com/${GITHUB_OWNER}
    Git PAT:      **********

"

cyellow
ctab "-"
typewriter "${note}"
cnone