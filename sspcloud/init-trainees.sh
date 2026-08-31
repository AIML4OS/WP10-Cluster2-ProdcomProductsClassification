#!/bin/bash

# Get repository name from the Git repository configured by Onyxia
export MY_REPO="$(basename "${GIT_REPOSITORY%.git}")"

echo "Repository: $MY_REPO"

# Restore the environment
sh "/home/onyxia/work/$MY_REPO/sspcloud/restore_environment.sh"

# Download data
bash "/home/onyxia/work/$MY_REPO/sspcloud/download_data.sh"

# Prepare the notebook
export NOTEBOOK_PATH="$1"

echo "Notebook path: $NOTEBOOK_PATH"

bash "/home/onyxia/work/$MY_REPO/sspcloud/download_notebook.sh"
