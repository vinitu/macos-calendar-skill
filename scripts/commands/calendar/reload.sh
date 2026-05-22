#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/_lib/common.sh"
require_arg "${1:-}" "calendar name"
run_backend calendar reload "$@"
