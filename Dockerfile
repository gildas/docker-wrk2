FROM alpine as builder

RUN   apk update && apk upgrade \
   && apk add --no-cache git alpine-sdk openssl-dev zlib-dev

RUN git clone https://github.com/giltene/wrk2.git \
    && cd wrk2 \
    && make

FROM alpine
LABEL org.opencontainers.image.title="wrk2"
LABEL org.opencontainers.image.description="Runs wrk2"
LABEL org.opencontainers.image.authors="Gildas Cherruel <gildas.cherruel@genesys.com>"
LABEL org.opencontainers.image.version="0.0.2"
LABEL org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache libgcc

RUN addgroup -S wrk2 && \
    adduser  -S -g wrk2 wrk2

ENV APP_ROOT /

WORKDIR ${APP_ROOT}
COPY --from=builder /wrk2/wrk ${APP_ROOT}

USER wrk2

ENTRYPOINT [ "/wrk" ]
