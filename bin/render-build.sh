#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
npm install flowbite

bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

