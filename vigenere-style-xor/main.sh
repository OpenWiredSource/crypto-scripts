#!/usr/bin/env bash
set -euo pipefail

plaintext="${1:?usage: $0 <plaintext> <key>}"
key="${2:?usage: $0 <plaintext> <key>}"

python3 - "$plaintext" "$key" <<'PY'
import sys
p = sys.argv[1].encode()
k = sys.argv[2].encode()

# include null terminator like C string
data = p + b'\x00'
out = [b ^ k[ i % len(k)] for i ,b in enumerate(data)]
print(",".join(f"0x{x:02X}" for x in out))
PY

