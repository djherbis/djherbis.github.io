ssh-keygen -t rsa -q -N "" -f travis_key
touch .travis.yml
travis login --org
travis encrypt-file travis_key --add -r $REPO

# Configure travis (build if yml is present, build pushes)
# Add travis_key.pub to https://github.com/$REPO/settings/keys
