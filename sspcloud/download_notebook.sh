#!/bin/bash

echo "Preparing notebook..."

WORK_DIR="/home/onyxia/work/${MY_REPO}"
NOTEBOOK="${WORK_DIR}/${NOTEBOOK_PATH}"

if [ -f "$NOTEBOOK" ]; then
    echo "✓ Notebook found: $NOTEBOOK"
else
    echo "✗ Notebook not found: $NOTEBOOK"
    exit 1
fi

echo "✓ Notebook ready"

# Open the relevant notebook when starting JupyterLab
echo "c.LabApp.default_url = '/lab/tree/${NOTEBOOK_PATH}'" \
    >> /home/onyxia/.jupyter/jupyter_server_config.py

echo "✓ JupyterLab configured to open: ${NOTEBOOK_PATH}"