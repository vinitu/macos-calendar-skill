#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/_lib/common.sh"
require_arg "${1:-}" "view type"
run_backend calendar switch-view "$@"
