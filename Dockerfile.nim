# Adds the Nim toolchain (nim, nimble, nimgrep, nimsuggest...) plus the nph formatter and nimlangserver
# on top of hermes-sandbox:desktop-tools. Prebuilt official tarball from nim-lang.org, sha256 pinned.
# Needs on the base image: gcc, curl, git, xz-utils (all present in hermes-sandbox:desktop-tools).
#   docker build -t hermes-sandbox:nim -f Dockerfile.nim .
#   docker build --build-arg BASE=debian:trixie ...   # generic base: install gcc curl git xz-utils ca-certificates first
ARG BASE=hermes-sandbox:desktop-tools
FROM ${BASE}

USER root
ARG NIM_VERSION=2.2.12
ARG NIM_SHA256=7df1611449a6842af69322aa2c1206942982650a5f6bc0d37bc8ec109932f638
RUN curl -fsSL -o /tmp/nim.tar.xz https://nim-lang.org/download/nim-${NIM_VERSION}-linux_x64.tar.xz \
    && echo "${NIM_SHA256}  /tmp/nim.tar.xz" | sha256sum -c - \
    && mkdir -p /opt/nim && tar -xJf /tmp/nim.tar.xz -C /opt/nim --strip-components=1 \
    && rm /tmp/nim.tar.xz \
    && for b in /opt/nim/bin/*; do ln -sf "$b" /usr/local/bin/$(basename "$b"); done

# Dev tools installed root-owned into /opt/nim-tools (separate from the user's nimble dir below).
ARG NPH_VERSION=0.7.0
ARG NIMLANGSERVER_VERSION=1.14.0
RUN NIMBLE_DIR=/opt/nim-tools nimble install -y nph@${NPH_VERSION} nimlangserver@${NIMLANGSERVER_VERSION} \
    && ln -sf /opt/nim-tools/bin/nph /usr/local/bin/nph \
    && ln -sf /opt/nim-tools/bin/nimlangserver /usr/local/bin/nimlangserver \
    && rm -rf /opt/nim-tools/buildtemp /root/.nimble /tmp/nimblecache-* /tmp/choosenim-extraction

# User packages (nimble install) land in the persistent /workspace mount, so they survive container recreation.
ENV NIMBLE_DIR=/workspace/.nimble
ENV PATH=${PATH}:/workspace/.nimble/bin
USER pn
