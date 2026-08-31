#!/bin/bash

# Get the repository directory from the location of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

export MY_REPO="$(basename "$REPO_DIR")"

echo "Repository: $MY_REPO"
echo "Repository directory: $REPO_DIR"

# Restore the environment
sh "$REPO_DIR/sspcloud/restore_environment.sh"

# Download data
# This script is run with bash because there is a bash array
bash "$REPO_DIR/sspcloud/download_data.sh"

# Prepare the ClassifAI notebook
export NOTEBOOK_PATH="$1"
bash "$REPO_DIR/sspcloud/download_notebook.sh"
