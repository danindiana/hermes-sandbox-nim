# Changelog

## 2026-10-07
- Added `Dockerfile.nim` (FROM `hermes-sandbox:desktop-tools`): Nim 2.2.12 from the official prebuilt tarball, sha256-pinned, installed to `/opt/nim`, binaries symlinked into `/usr/local/bin`.
- Switched `terminal.docker_image` to `hermes-sandbox:nim`.
- Copied Nim into the running container `hermes-d1c35658` so it worked without a recreate.
- Verified: hello-world compile+run, `nimble` v0.24.1, compile+run in `/workspace` of the live container.
- Found: `/tmp` in the sandbox is noexec; run compiled binaries from `/workspace`.
