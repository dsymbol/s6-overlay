FROM alpine:3.20 AS base

ARG S6_VERSION
ARG S6_DIR="/s6"
ARG S6_URL="https://github.com/just-containers/s6-overlay/releases/download"

RUN mkdir -p $S6_DIR; \
    apk update; \
    apk add --no-cache xz wget; \
    ARCH=$(arch); \
    case "$ARCH" in \
        aarch64 ) export S6_ARCH='aarch64'                      ;; \
        arm64   ) export S6_ARCH='aarch64'                      ;; \
        armhf   ) export S6_ARCH='armhf'                        ;; \
        arm*    ) export S6_ARCH='arm'                          ;; \
        i4*     ) export S6_ARCH='i486'                         ;; \
        i6*     ) export S6_ARCH='i686'                         ;; \
        s390*   ) export S6_ARCH='s390x'                        ;; \
        x86_64  ) export S6_ARCH='x86_64'                       ;; \
        riscv64 ) export S6_ARCH='riscv64'                      ;; \
        ppc64le ) export S6_ARCH='powerpc64le'                  ;; \
        *       ) echo "Unsupported platform: $S6_ARCH"; exit 1 ;; \
    esac; \
    wget --no-check-certificate -O- ${S6_URL}/v${S6_VERSION}/s6-overlay-noarch.tar.xz | tar Jxp -C $S6_DIR; \
    wget --no-check-certificate -O- ${S6_URL}/v${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz | tar Jxp -C $S6_DIR; \
    wget --no-check-certificate -O- ${S6_URL}/v${S6_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar Jxp -C $S6_DIR; \
    wget --no-check-certificate -O- ${S6_URL}/v${S6_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar Jxp -C $S6_DIR

FROM scratch
COPY --from=base /s6 /s6
