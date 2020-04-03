FROM golang:latest
RUN addgroup --gid 10001 app
RUN adduser --gid 10001 --uid 10001 \
    --home /app --shell /sbin/nologin \
    --disabled-password app

RUN mkdir /app/statics/
ADD statics /app/statics/

COPY bin/invoicer /app/invoicer
USER app
EXPOSE 8080
WORKDIR /app
ENTRYPOINT /app/invoicer

FROM busybox:latest
RUN addgroup -g 10001 app && \
    adduser -G app -u 10001 \
    -D -h /app -s /sbin/nologin app
COPY bin/invoicer /bin/invoicer
USER app
EXPOSE 8080
ENTRYPOINT /bin/invoicer


