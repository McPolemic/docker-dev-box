FROM ubuntu:xenial
MAINTAINER Adam Lukens "spawn968@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN apt-get install -y tmux
RUN apt-get install -y build-essential
RUN apt-get install -y zsh

# Install Python
RUN apt-get install -y python python-pip
RUN pip install virtualenv ipython honcho

# Install Ruby
RUN apt-get install -y ruby-dev ruby
RUN gem install --no-rdoc --no-ri pry bundler rails

# Install Go
#RUN curl https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar -C /usr/local -zx
#ENV GOROOT /usr/local/go
#ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /home/dev/src/go:$GOPATH

# Setup home environment
# Cribbed from https://github.com/shykes/devbox/blob/master/Dockerfile
RUN useradd dev
RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/src/go /home/dev/bin
ENV PATH /home/dev/bin:$PATH

# Copy over dotfiles
RUN curl -s https://raw.githubusercontent.com/McPolemic/dotfiles/master/bin/install.sh | /bin/bash

# Cleanup
RUN apt-get clean

WORKDIR /home/dev
ENV HOME /home/dev
RUN chown -R dev: /home/dev
USER dev

ENTRYPOINT ["zsh"]
