FROM ubuntu
MAINTAINER Adam Lukens "spawn968@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y python python-setuptools python-pip
RUN apt-get install -y python-software-properties software-properties-common git build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev curl ruby2.0-dev vim

# Install python pre-reqs
RUN pip install virtualenv ipython honcho

# Install Ruby
RUN apt-get install -y ruby2.0-dev ruby2.0 ruby-dev && \
    update-alternatives --install /usr/bin/gem gem /usr/bin/gem2.0 10 && \
    update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10

# Install necessary Ruby dependencies
RUN gem install --no-rdoc --no-ri pry bundler

# Cleanup
RUN apt-get clean

ENTRYPOINT ["bash"]
