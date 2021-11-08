#!/bin/sh

# If there is some public key in keys folder
# then it copies its contain in authorized_keys file
if [ "$(ls -A /git-server/keys/)" ]; then
  cd /home/git
  sed 's/^/restrict /' /git-server/keys/*.pub > .ssh/authorized_keys
  chown -R git:git .ssh
  chmod 700 .ssh
  chmod 600 .ssh/*
fi

chown -R git:git /git-server/ 

for PROJECT in $GIT_PROJECTS
do
  # Only create the repos if they dont exist
  if [ ! -d /git-server/repos/$PROJECT.git ]; then
      echo "Creating project $PROJECT"
      DIRECTORY="/git-server/repos/$PROJECT.git"
      mkdir $DIRECTORY -p 
      cd $DIRECTORY && git init --bare 
      chown -R git:git $DIRECTORY
  fi
done

ssh-keygen -A

exec /usr/sbin/sshd -D 
