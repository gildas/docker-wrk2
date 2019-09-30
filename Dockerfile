FROM alpine as builder

RUN   apk update && apk upgrade \
   && apk add --no-cache git alpine-sdk openssl-dev zlib-dev

RUN git clone https://github.com/giltene/wrk2.git \
    && cd wrk2 \
    && make

FROM alpine
LABEL maintainer="Gildas Cherruel <gildas@breizh.org>"
LABEL version="0.0.1"
LABEL description="Runs wrk2"

RUN apk add --no-cache libgcc

RUN addgroup -S wrk2 && \
    adduser  -S -g wrk2 wrk2

ENV APP_ROOT /

WORKDIR ${APP_ROOT}
COPY --from=builder /wrk2/wrk ${APP_ROOT}

USER wrk2

ENTRYPOINT [ "/wrk" ]
