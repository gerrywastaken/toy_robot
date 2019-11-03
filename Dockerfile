# build stage
FROM ruby:2.5.0-alpine AS pre-builder

ARG build_without=""
ENV SECRET_KEY_BASE=dumb

RUN apk add --update --no-cache \
openssl \
tar \
build-base \
tzdata \
&& mkdir -p /var/app

ENV BUNDLE_PATH="/gems" BUNDLE_JOBS=4 BUNDLE_WITHOUT=${bundle_without}

COPY Gemfile Gemfile.lock /var/app/
WORKDIR /var/app

RUN bundle install \
&& rm -rf /gems/cache/*.gem \
&& find /gems/gems/ -name "*.c" -delete \
&& find /gems/gems/ -name "*.o" -delete

# final stage
FROM ruby:2.5.0-alpine

RUN apk add --update --no-cache \
openssl \
tzdata

COPY --from=pre-builder /gems/ /gems/
COPY . /var/app/

WORKDIR /var/app
ARG build_without=""
ENV BUNDLE_PATH="/gems" BUNDLE_JOBS=4 BUNDLE_WITHOUT=${bundle_without}

ENTRYPOINT [ "./docker/entrypoint.sh" ]
