FROM alpine:latest
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            ruby-irb \
                            ruby-dev && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluentd -v 0.12.23 && \
    gem install fluent-plugin-google-cloud && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
ADD fluent.conf /fluentd/etc/fluent.conf
EXPOSE 24224
CMD ["fluentd", "--config", "/fluentd/etc/fluent.conf"]