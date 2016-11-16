FROM alpine
RUN apk add --no-cache curl nginx
RUN curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip >/tmp/ngrok.zip && \
    unzip -d /usr/local/bin /tmp/ngrok.zip && \
    rm -f /tmp/ngrok.zip
RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 >/usr/local/bin/jq && \
    chmod +x /usr/local/bin/jq
COPY nginx.conf /etc/nginx/nginx.conf
COPY supergrok.sh /bin/supergrok.sh
CMD ["supergrok.sh"]
