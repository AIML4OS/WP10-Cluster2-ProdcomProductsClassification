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

# Configure JupyterLab to open the notebook automatically
mkdir -p /home/onyxia/.jupyter

NOTEBOOK_URL="/lab/tree/${MY_REPO}/${NOTEBOOK_PATH}"

echo "c.ServerApp.default_url = '${NOTEBOOK_URL}'" \
    >> /home/onyxia/.jupyter/jupyter_server_config.py

echo "c.LabApp.default_url = '${NOTEBOOK_URL}'" \
    >> /home/onyxia/.jupyter/jupyter_server_config.py

echo "✓ JupyterLab configured to open: ${NOTEBOOK_URL}"

# echo "c.ServerApp.default_url = '/lab/tree/${MY_REPO}/${NOTEBOOK_PATH}'" \
#     >> /home/onyxia/.jupyter/jupyter_server_config.py

# echo "✓ JupyterLab configured to open: ${MY_REPO}/${NOTEBOOK_PATH}"
