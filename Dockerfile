FROM python:3.7-alpine
MAINTAINER devobiero

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client

# system libs required to install psycopg2
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev

RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create user for running applications only
# for security purposes, don't run as root user
RUN adduser -D user
USER user