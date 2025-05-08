#!/bin/bash
# ref: https://github.com/norwoodj/helm-docs
set -eux

CHART_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
echo "Chart directory: $CHART_DIR"

echo "Running Helm Docs..."
docker run \
    --rm \
    -v "$CHART_DIR:/helm-docs" \
    -u "$(id -u):$(id -g)" \
    jnorwood/helm-docs:v1.10.0 \
    --chart-search-root=/helm-docs