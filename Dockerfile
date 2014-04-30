FROM ubuntu
MAINTAINER Adam Lukens "spawn968@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list
RUN apt-get -y update

# Install node.js
RUN apt-get install -y python-software-properties software-properties-common python python-setuptools git build-essential build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev curl ruby2.0-dev
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get -y update
RUN apt-get install -y nodejs

# Install various node.js globals needed.
RUN npm config set strict-ssl false
RUN npm install -g coffee-script brunch bower

# Install Ruby
RUN apt-get install -y ruby2.0-dev ruby2.0 ruby-dev
RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10

# Install necessary Ruby dependencies
RUN gem install --no-rdoc --no-ri pry --pre
RUN gem install --no-rdoc --no-ri bundler

# Cleanup
RUN apt-get clean
