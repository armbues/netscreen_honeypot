FROM phusion/baseimage:latest

RUN apt-get update && apt-get upgrade -yq && \
	apt-get install -yq build-essential python python-pip python-dev unzip openssl libffi-dev libssl-dev

ADD requirements.txt /
RUN pip install -r requirements.txt

ADD https://github.com/micheloosterhof/cowrie/archive/master.zip /tmp/cowrie.zip
RUN unzip /tmp/cowrie.zip && \
	mv /cowrie-master /cowrie

COPY . /cowrie
WORKDIR /cowrie

RUN adduser --disabled-password cowrie --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --no-create-home
RUN chown -R cowrie.cowrie /cowrie
USER cowrie

EXPOSE 2222

CMD ./start.sh && tail -F log/cowrie.log