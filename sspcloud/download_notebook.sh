#!/bin/bash

echo "Preparing ClassifAI notebook..."

WORK_DIR="/home/onyxia/work/${MY_REPO}"
NOTEBOOK="${WORK_DIR}/notebooks/ClassifAI_notebook.ipynb"

if [ -f "$NOTEBOOK" ]; then
    echo "✓ Notebook found: $NOTEBOOK"
else
    echo "✗ Notebook not found: $NOTEBOOK"
    exit 1
fi

echo "✓ Notebook ready"
