#!/usr/bin/env bash
set -euo pipefail

SUITE=${TEST_SUITE:-all}
mkdir -p results

if [[ "$SUITE" == "smoke" ]]; then
  pytest -m smoke --junitxml=results/junit.xml
elif [[ "$SUITE" == "regression" ]]; then
  pytest -m regression --junitxml=results/junit.xml
else
  pytest --junitxml=results/junit.xml
fi
