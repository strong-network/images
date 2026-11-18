# Slim generic image — the minimum userland needed to run strong-ide.

# Build stage: compile git-lfs from source using Go 1.26.4.
# CGO_ENABLED=0 produces a fully static binary with no runtime dependencies.
# Using a separate build stage ensures the Go toolchain (~500MB) never appears in the final image.
# The distro git-lfs package is built with an outdated Go and carries known CVEs; building from
# source lets us pin a modern toolchain and bump vulnerable transitive deps. We build the latest
# stable release tag (v3.7.1, which includes the CVE-2025-26625 fix) rather than the prebuilt
# release binary so we control the Go version and dep versions.
FROM golang:1.26.4 AS git-lfs-builder
RUN GIT_LFS_VERSION="v3.7.1" && \
    curl -fsSL "https://github.com/git-lfs/git-lfs/archive/refs/tags/${GIT_LFS_VERSION}.tar.gz" -o /tmp/git-lfs-src.tar.gz && \
    tar -xzf /tmp/git-lfs-src.tar.gz -C /tmp && \
    cd "/tmp/git-lfs-${GIT_LFS_VERSION#v}" && \
    # Bump vulnerable transitive deps before building:
    go get golang.org/x/crypto@v0.52.0 golang.org/x/net@v0.55.0 && \
    go mod tidy && \
    CGO_ENABLED=0 go build -o /usr/local/bin/git-lfs .

FROM ubuntu:24.04

# Copy the git-lfs binary compiled in the build stage above. /usr/local/bin precedes /usr/bin on
# PATH, so this replaces any distro git-lfs.
COPY --from=git-lfs-builder /usr/local/bin/git-lfs /usr/local/bin/git-lfs

ENV SHELL=/bin/bash
ENV LANG=C.UTF-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && \
    apt-get -y upgrade && \
    # openssh-client provides ssh-agent/ssh-add used by docker_entrypoint.sh and
    # enables git-over-ssh.
    apt-get install -y --no-install-recommends ca-certificates git openssh-client && \
    git lfs install --system && \
    # ubuntu:24.04 ships an unused default `ubuntu` user at uid 1000 — remove it
    userdel -r ubuntu && \
    useradd --uid 1000 --create-home --shell /bin/bash developer && \
    # Note: /home/developer keeps useradd's default 0700 here; init.sh widens it to
    # 777 at pod startup (chmod -R 777 /home/developer), so no build-time chmod needed.
    #
    # The injected /strong/bin/sudo is a custom setuid-root Go binary (//go/cmd/sudo)
    # that runs its args as uid 0 and ignores /etc/sudoers entirely — so no sudo
    # package and no sudoers drop-in are needed here.
    #
    # Pre-create the Strong Network startup dir: the extension-install step
    # (move_uploaded_extensions.sh, run by strongcli as uid 1000) does
    # `mkdir -p /usr/bin/strong_network_startup/vscode_extensions`, which would fail
    # under root-owned /usr/bin. Only uid 1000 (or root) writes here, so owning it as
    # developer with the default 0755 is sufficient — no world-writable 777.
    mkdir -p /usr/bin/strong_network_startup && \
    chown developer:developer /usr/bin/strong_network_startup && \
    rm -rf /var/lib/apt/lists/*

USER 1000
WORKDIR /home/developer
