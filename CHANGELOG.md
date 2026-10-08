# Changelog

## 2026-10-07 (later)
- `Dockerfile.nim`: `ARG BASE`, added `nph` 0.7.0 and `nimlangserver` 1.14.0 in `/opt/nim-tools`, `NIMBLE_DIR=/workspace/.nimble`, cleanup of root-owned `/tmp/nimblecache-*` (fixed `nimble install` for the unprivileged user).
- Verified nimble persistence across containers under the real egress network; verified Nim end to end through Hermes (host-side file check + independent run).
- Checked 53 pre-existing `.nim` files: 12 compile, 41 fail (source errors, not environment).
- Found Hermes was using a different container (`hermes-1226694b`) than the one patched first; patched both.
- Added CI (`verify.yml`, `ci/Dockerfile.base`), diagrams 08-10, README update section.

## 2026-10-07
- Added `Dockerfile.nim` (FROM `hermes-sandbox:desktop-tools`): Nim 2.2.12 from the official prebuilt tarball, sha256-pinned, installed to `/opt/nim`, binaries symlinked into `/usr/local/bin`.
- Switched `terminal.docker_image` to `hermes-sandbox:nim`.
- Copied Nim into the running container `hermes-d1c35658` so it worked without a recreate.
- Verified: hello-world compile+run, `nimble` v0.24.1, compile+run in `/workspace` of the live container.
- Found: `/tmp` in the sandbox is noexec; run compiled binaries from `/workspace`.
