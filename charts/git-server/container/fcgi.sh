#!/bin/bash

# Initializes fcgiwrap for the git http-backend

set -o errexit -o nounset

readonly GIT_PROJECT_ROOT="/var/lib/git"

# String list of repos to create
readonly GIT_REPOS=$1

main() {
  mkdir -p $GIT_PROJECT_ROOT
  echo "Found $GIT_REPOS"

  git config --global init.defaultBranch main

  if [[ -n $GIT_REPOS ]]; then
    echo "Initializing repos $GIT_REPOS"
    initialize_initial_repositories
  fi
  initialize_services
}

initialize_services() {
  # Check permissions on $GIT_PROJECT_ROOT
  chown -R git:git $GIT_PROJECT_ROOT
  chmod -R 775 $GIT_PROJECT_ROOT

  exec /usr/bin/spawn-fcgi -p 9000 -n -- "/usr/bin/fcgiwrap" -f
}

initialize_initial_repositories() {
  for dir in $GIT_REPOS; do
    echo "Initializing repository $dir"
    init_and_commit $dir
  done
}

init_and_commit() {
  local dir=$1

  mkdir -p $GIT_PROJECT_ROOT/$dir.git
  cd $GIT_PROJECT_ROOT/$dir.git

  git init --bare
}

main "$@"
