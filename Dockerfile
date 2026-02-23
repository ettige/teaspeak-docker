FROM debian:bookworm-slim

ARG TARGETARCH
ARG TEASPEAK_CHANNEL=stable

RUN adduser --disabled-login --gecos "" teaspeak

WORKDIR /opt/teaspeak

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tar bash ca-certificates ffmpeg && \
    rm -rf /var/lib/apt/lists/*

RUN TEA_VERSION=$(curl -s https://repo.teaspeak.de/server/linux/amd64_stable/latest) && \
    curl -O https://repo.teaspeak.de/server/linux/amd64_stable/TeaSpeak-$TEA_VERSION.tar.gz && \
    tar -xzf TeaSpeak-$TEA_VERSION.tar.gz && \
    rm TeaSpeak-$TEA_VERSION.tar.gz

RUN chown -R teaspeak:teaspeak /opt/teaspeak

USER teaspeak

CMD ["./TeaSpeakServer"]
