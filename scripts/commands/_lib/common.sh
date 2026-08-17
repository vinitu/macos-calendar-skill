#!/usr/bin/env bash
# Shared helpers for calendar command wrappers.
#
# AppleScript backends (scripts/applescripts/<entity>/<action>.applescript)
# emit plain text. This library wraps their output in the JSON envelope
# documented in SKILL.md so the public scripts/commands interface is JSON-first.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

JQ_BIN="${JQ_BIN:-}"
if [[ -z "$JQ_BIN" ]]; then
  if JQ_BIN="$(command -v jq 2>/dev/null)"; then
    :
  elif [[ -x "/opt/homebrew/bin/jq" ]]; then
    JQ_BIN="/opt/homebrew/bin/jq"
  else
    JQ_BIN=""
  fi
fi

# Read stdin and emit a valid JSON string literal (quoted).
# Prefers jq for correctness; falls back to a bash-only escaper so the skill
# keeps working without jq (dependency-light: bash + osascript).
_json_string() {
  if [[ -n "$JQ_BIN" ]]; then
    "$JQ_BIN" -jRs '.'
    return
  fi
  local s
  s="$(cat)"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/\\r}"
  s="${s//$'\t'/\\t}"
  printf '"%s"' "$s"
}

json_fail() {
  local msg="$1"
  local escaped
  escaped="$(printf '%s' "$msg" | _json_string)"
  printf '{"success":false,"error":%s}\n' "$escaped"
  exit 1
}

json_ok() {
  local payload="${1:-{}}"
  printf '{"success":true,"data":%s}\n' "$payload"
}

# Wrap plain-text backend output in the success JSON envelope.
# Empty backend output becomes {"success":true,"data":null}.
json_wrap() {
  local text
  text="$(cat)"
  if [[ -z "$text" ]]; then
    printf '{"success":true,"data":null}\n'
    return
  fi
  local escaped
  escaped="$(printf '%s' "$text" | _json_string)"
  printf '{"success":true,"data":%s}\n' "$escaped"
}

# Value-based guard for a single required positional argument (emits JSON).
require_arg() {
  local v="${1:-}" l="$2"
  [[ -z "$v" ]] && json_fail "missing ${l}"
}

# Count-based guard for a minimum number of positional arguments (emits JSON).
require_args() {
  local have="$1" need="$2" what="$3"
  if [[ "$have" -lt "$need" ]]; then
    json_fail "missing ${what}"
  fi
}

# Print a human-readable usage line to stderr and exit non-zero.
# Used for structural errors (too many arguments), not for missing args.
usage() {
  echo "Usage: $*" >&2
  exit 1
}

backend_script() {
  local e="$1" a="$2"
  printf '%s/scripts/applescripts/%s/%s.applescript' "$ROOT_DIR" "$e" "$a"
}

run_backend() {
  local e="$1" a="$2"; shift 2
  local sp; sp="$(backend_script "$e" "$a")"
  [[ -f "$sp" ]] || json_fail "backend script not found: ${sp}"
  local out err rc tmp
  tmp="$(mktemp -t calbackend)"
  out="$(osascript "$sp" "$@" 2>"$tmp")" && rc=0 || rc=$?
  err="$(cat "$tmp" 2>/dev/null)"; rm -f "$tmp"
  if [[ "$rc" -ne 0 ]]; then
    local msg="backend ${e}/${a} failed (exit ${rc})"
    [[ -n "$err" ]] && msg="$err"
    json_fail "$msg"
  fi
  printf '%s' "$out" | json_wrap
}