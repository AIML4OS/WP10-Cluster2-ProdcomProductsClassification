#!/bin/bash

# Get the repository containing this initialization script
export MY_REPO=$(find /home/onyxia/work -maxdepth 2 \
    -type f \
    -path "*/sspcloud/init-trainees.sh" \
    -print -quit |
    sed 's|/home/onyxia/work/||' |
    sed 's|/sspcloud/init-trainees.sh||')

echo "Repository: $MY_REPO"

# Restore the environment
sh $MY_REPO/sspcloud/restore_environment.sh

# Download data
# This script is run with bash because there is a bash array
bash $MY_REPO/sspcloud/download_data.sh

# Prepare the ClassifAI notebook
export NOTEBOOK_PATH=$1
bash $MY_REPO/sspcloud/download_notebook.sh
