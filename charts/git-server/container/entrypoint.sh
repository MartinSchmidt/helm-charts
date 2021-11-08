#!/bin/bash

# Initializes Nginx and the git cgi scripts
# for git http-backend through fcgiwrap.
#
# Usage:
#   entrypoint <commands>
#
# Commands:
#   -start    starts the git server (nginx + fcgi)
#


set -o errexit

readonly GIT_PROJECT_ROOT="/var/lib/git"
readonly GIT_HTTP_EXPORT_ALL="true"
readonly GIT_USER="git"
readonly GIT_GROUP="git"

readonly FCGIPROGRAM="/usr/bin/fcgiwrap"
readonly USERID="nginx"
readonly SOCKUSERID="$USERID"
readonly FCGISOCKET="/var/run/fcgiwrap.socket"

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

  echo "Starting fcgi"

  /usr/bin/spawn-fcgi \
    -s $FCGISOCKET \
    -F 4 \
    -u $USERID \
    -g $USERID \
    -U $USERID \
    -G $GIT_GROUP -- \
    "$FCGIPROGRAM"

   echo "Started fcgi"

  exec nginx 
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
