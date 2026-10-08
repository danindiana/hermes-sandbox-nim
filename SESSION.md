# Session 1791420060: Nim in the Hermes sandbox
Task: install https://nim-lang.org/ for the Hermes Agent Docker sandbox, then publish a writeup repo.
Result: image `hermes-sandbox:nim`, config switched (backup `~/.hermes/config.yaml.bak-nim`, not published), live container patched via docker cp.
Repo: github.com/danindiana/hermes-sandbox-nim (this folder is the repo root).
Not tested: Hermes itself invoking `nim` through its terminal tool.
