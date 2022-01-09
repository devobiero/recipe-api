FROM python:3.7-alpine
MAINTAINER devobiero

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev

# system libs required to install psycopg2 and Pillow package
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev \
    zlib zlib-dev

RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# used to store files
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

# create user for running applications only
RUN adduser -D user

# Make user owner of /vol
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web

# for security purposes, don't run as root user
USER user