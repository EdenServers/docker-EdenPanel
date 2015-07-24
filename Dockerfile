FROM ruby:2.2.2

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get -y install git
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y nodejs
RUN apt-get install -y redis-server

VOLUME ["/home/edenapi", "/home/edenpanel", "/var/lib/redis"]
RUN gem install bundler
RUN gem install passenger

ADD start.sh /start.sh
RUN chmod 755 /start.sh

ENV SECRET_KEY_BASE 628e6a76cce9d544a5d4c9e93beb067c0864fab1daa4dacf2eeff9bab723a0b5
EXPOSE 3000
CMD ["/start.sh"]
