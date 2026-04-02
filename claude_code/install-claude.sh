#!/bin/bash
set -e

apt-get update
apt-get install -y ca-certificates curl jq

GCS_BUCKET="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"

# Detect platform
case "$(uname -m)" in
  x86_64|amd64) arch="x64" ;;
  arm64|aarch64) arch="arm64" ;;
  *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

if [ -f /lib/libc.musl-x86_64.so.1 ] || [ -f /lib/libc.musl-aarch64.so.1 ] || ldd /bin/ls 2>&1 | grep -q musl; then
  platform="linux-${arch}-musl"
else
  platform="linux-${arch}"
fi

# Fetch latest version and manifest
version=$(curl -fsSL "$GCS_BUCKET/latest")
manifest_json=$(curl -fsSL "$GCS_BUCKET/$version/manifest.json")
checksum=$(echo "$manifest_json" | jq -r ".platforms[\"$platform\"].checksum // empty")

if [ -z "$checksum" ] || [[ ! "$checksum" =~ ^[a-f0-9]{64}$ ]]; then
  echo "Platform $platform not found in manifest" >&2
  exit 1
fi

# Download binary and verify checksum
mkdir -p /opt/claude-installer
curl -fsSL -o /opt/claude-installer/claude "$GCS_BUCKET/$version/$platform/claude"

actual=$(sha256sum /opt/claude-installer/claude | cut -d' ' -f1)
if [ "$actual" != "$checksum" ]; then
  echo "Checksum verification failed" >&2
  rm -f /opt/claude-installer/claude
  exit 1
fi

chmod +x /opt/claude-installer/claude

# Create wrapper script at /usr/bin/claude (offline first-run installer)
cat > /usr/bin/claude <<'WRAPPER'
#!/bin/bash
if [ ! -x "$HOME/.local/bin/claude" ]; then
  echo "Setting up Claude Code for the first time (this only happens once)..."
  /opt/claude-installer/claude install
fi
exec "$HOME/.local/bin/claude" "$@"
WRAPPER
chmod +x /usr/bin/claude

# Cleanup
rm -rf /var/lib/apt/lists/*
