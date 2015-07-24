#!/bin/bash
redis-server &

if [ "$(ls -A /home/edenapi )" ]; then
     cd /home/edenapi && git pull
else
    git clone https://github.com/EdenServers/EdenAPI.git /home/edenapi
fi

cd /home/edenapi && bundle install
cd /home/edenapi && RAILS_ENV=production bundle exec rake db:migrate
cd /home/edenapi && foreman start -f Procfile.production &

if [ "$(ls -A /home/edenpanel )" ]; then
     cd /home/edenpanel && git pull
else
    git clone https://github.com/EdenServers/EdenPanel.git /home/edenpanel
fi

cd /home/edenpanel && bundle install --without test development
cd /home/edenpanel && RAILS_ENV=production bundle exec rake db:migrate
cd /home/edenpanel && RAILS_ENV=production bin/rake assets:precompile
cd /home/edenpanel && RAILS_ENV=production bundle exec rake db:seed
cd /home/edenpanel && foreman start -f Procfile.production
