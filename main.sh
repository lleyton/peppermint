# pepper + mint = beautiful self-hosted documentation

# Link to a tarball containing the Mint client code, under the client/ subdirectory.
# For the sake of not getting wacked by Mintlify, we'll use my archive of the last open source release, with a few changes for self-hosting.
MINT_URL="https://github.com/lleyton/mint/tarball/ashen"

TMP_MINT_DIR=$(mktemp -d)
curl -L "$MINT_URL" | tar -xz --strip-components=1 -C "$TMP_MINT_DIR"

if [[ -n "$1" ]]; then
  TARGET_DIR="$1"
else
  TARGET_DIR="$(pwd)"
fi

(
  cd "$TMP_MINT_DIR/client"
  yarn install
  yarn preconfigure "$TARGET_DIR"
  yarn build
)

mv "$TMP_MINT_DIR/client" "$TARGET_DIR/out"
