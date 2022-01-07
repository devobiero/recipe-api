FROM python:3.7-alpine
MAINTAINER devobiero

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create user for running applications only
# for security purposes, don't run as root user
RUN adduser -D user
USER user