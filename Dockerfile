FROM alpine:latest
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            ruby-irb \
                            ruby-dev && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluentd -v 0.14.1 && \
    gem install fluent-plugin-google-cloud && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* && \
    ls -d /usr/lib/ruby/gems/*/gems/google-api-client-*/generated/google/apis/* | grep -v logging_v1beta3 | xargs rm -Rf
ADD fluent.conf /fluentd/etc/fluent.conf
EXPOSE 24224
CMD ["fluentd", "--config", "/fluentd/etc/fluent.conf"]