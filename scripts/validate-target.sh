#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test -f "${ROOT_DIR}/packages/target-linux/package.toml"
for tool in run publish doctor flash prepare-qemu; do
  test -x "${ROOT_DIR}/packages/target-linux/tools/${tool}"
  sh -n "${ROOT_DIR}/packages/target-linux/tools/${tool}"
done
grep -q 'types = .*"target"' "${ROOT_DIR}/packages/target-linux/package.toml"
grep -q 'hostAbi = 1' "${ROOT_DIR}/packages/target-linux/package.toml"
echo "target-linux validation: PASS"
