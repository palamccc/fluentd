FROM buildpack-deps:jessie-curl
RUN sh -c "curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -" \
    && echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/treasure-data.list \
    && apt-get update \
    && apt-get install -y --force-yes td-agent \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
VOLUME [ "/fluentd" ]
EXPOSE 24224
CMD [ "td-agent", "--no-supervisor", "--config", "/fluentd/logs.conf" ]
