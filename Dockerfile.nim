# Adds the Nim toolchain (nim, nimble, nimgrep, nimsuggest...) on top of hermes-sandbox:desktop-tools.
# Prebuilt official tarball from nim-lang.org, sha256 pinned. gcc is already in the base image.
#   docker build -t hermes-sandbox:nim -f Dockerfile.nim .
FROM hermes-sandbox:desktop-tools

USER root
ARG NIM_VERSION=2.2.12
ARG NIM_SHA256=7df1611449a6842af69322aa2c1206942982650a5f6bc0d37bc8ec109932f638
RUN curl -fsSL -o /tmp/nim.tar.xz https://nim-lang.org/download/nim-${NIM_VERSION}-linux_x64.tar.xz \
    && echo "${NIM_SHA256}  /tmp/nim.tar.xz" | sha256sum -c - \
    && mkdir -p /opt/nim && tar -xJf /tmp/nim.tar.xz -C /opt/nim --strip-components=1 \
    && rm /tmp/nim.tar.xz \
    && for b in /opt/nim/bin/*; do ln -sf "$b" /usr/local/bin/$(basename "$b"); done
USER pn
