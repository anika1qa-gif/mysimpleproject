#!/usr/bin/env bash
set -euo pipefail
mkdir -p dist
tar -czf dist/app.tgz src
