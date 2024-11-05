FROM alpine:3.11 AS builder

ARG PACKET_VER
ARG DEBUG
ARG ENABLE_WEB_SERVICE

WORKDIR /rathena

RUN mkdir -p ./conf/import ./conf/msg_conf/import ./db/import

RUN --mount=type=cache apk add wget git cmake make gdb zlib-dev ca-certificates linux-headers bash valgrind gcc g++ netcat-openbsd mariadb-dev
RUN wget https://raw.githubusercontent.com/eficode/wait-for/v2.2.2/wait-for -O /bin/wait-for && chmod +x /bin/wait-for


ADD ./3rdparty ./3rdparty/

ADD ./src ./src/

ADD ./conf/import-tmpl ./conf/import-tmpl
ADD ./conf/msg_conf/import-tmpl ./conf/msg_conf/import-tmpl
ADD ./db/import-tmpl/ ./db/import-tmpl/

ADD ./tools/docker/builder.sh ./tools/docker/builder.sh
ADD ./configure* ./CMakeLists.txt ./Makefile.in ./

RUN "./tools/docker/builder.sh"



FROM alpine:3.11 AS base
COPY --from=builder /bin/wait-for /bin/wait-for

ADD .git/refs/heads/master .git/refs/heads/master
ADD .git/refs/remotes/origin/master .git/refs/remotes/origin/master

WORKDIR /rathena

RUN apk add --no-cache netcat-openbsd mariadb-dev

ADD ./conf ./conf/
ADD ./tools/docker/asset/char_conf.txt ./tools/docker/asset/map_conf.txt ./tools/docker/asset/inter_conf.txt ./conf/import/

ENTRYPOINT [ "/bin/wait-for", "db:3306", "--timeout=60", "--" ]



FROM base AS login-server

COPY --from=builder /rathena/login-server .

USER 1000

CMD [ "/rathena/login-server" ]



FROM base AS char-server

COPY --from=builder /rathena/char-server .

ADD ./db ./db/

USER 1000

CMD [ "/rathena/char-server" ]



FROM base AS map-server

COPY --from=builder /rathena/map-server .

ADD ./db ./db/
ADD ./npc ./npc/

USER 1000

CMD [ "/rathena/map-server" ]



FROM base AS web-server

COPY --from=builder /rathena/web-server .

USER 1000

CMD [ "/rathena/web-server" ]
