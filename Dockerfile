FROM ubuntu:xenial
MAINTAINER Adam Lukens "spawn968@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y git curl wget vim tmux zsh
RUN apt-get install -y build-essential zlib1g-dev

# Install Python
RUN apt-get install -y python python-pip
RUN pip install virtualenv ipython honcho

# Install Ruby
RUN apt-get install -y ruby-dev ruby
RUN gem install --no-rdoc --no-ri pry bundler rails

# Install Go
RUN apt-get install -y golang
ENV GOPATH /home/dev/src/go:$GOPATH

# Setup home environment
# Cribbed from https://github.com/shykes/devbox/blob/master/Dockerfile
RUN useradd dev
RUN usermod -aG sudo dev
RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/src/go
ENV PATH /home/dev/bin:$PATH

WORKDIR /home/dev
ENV HOME /home/dev
RUN chown -R dev: /home/dev

# Cleanup
RUN apt-get clean

USER dev

# Copy over dotfiles
RUN curl -s https://raw.githubusercontent.com/McPolemic/dotfiles/master/bin/install.sh | /bin/bash

ENTRYPOINT ["zsh"]
