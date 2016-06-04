#!/bin/bash

# Author:  Tobias Fischer (https://github.com/tofi86)
# Date:    2016-06-03

echo "# starting MySQL server..."
mysql.server start

echo "# fetching latest updates to Redmine trunk"
git checkout master
git pull

echo "# running migrations for latest Redmine trunk"
bundle update
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake tmp:cache:clear tmp:sessions:clear RAILS_ENV=development

echo "# starting Rails webserver...."
ruby bin/rails server webrick -p3001 -e development
