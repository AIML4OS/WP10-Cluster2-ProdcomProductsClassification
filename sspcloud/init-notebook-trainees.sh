#!/bin/bash

# ============================================================================
# Initialization script for PRODCOM Classification Notebook on SSPCloud
# ============================================================================
# This script prepares the environment for trainees to run the
# ClassifAI_notebook.ipynb on SSPCloud/Onyxia
#
# What it does:
# 1. Gets the repository name dynamically
# 2. Installs Python dependencies from requirements-notebook.txt
# 3. Ensures the PRODCOM data file is available
# 4. Creates output directory
# 5. Optionally launches Jupyter (commented out - let user start it)
#
# Usage:
# This script is typically called automatically by SSPCloud when launching
# a service with this repository configured.
# ============================================================================

# Exit on error
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  PRODCOM Product Classification - Notebook Setup                ║${NC}"
echo -e "${BLUE}║  Initializing environment for SSPCloud/Onyxia                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"

# ============================================================================
# Step 1: Determine the repository directory
# ============================================================================
echo -e "\n${YELLOW}[Step 1/5]${NC} Determining repository directory..."

# Get the repository name from current working directory
# On SSPCloud, the work directory is typically /home/onyxia/work or similar
MY_REPO=$(basename "$PWD")
echo -e "${GREEN}✓${NC} Repository: $MY_REPO"
echo -e "${GREEN}✓${NC} Working directory: $PWD"

# ============================================================================
# Step 2: Install Python dependencies
# ============================================================================
echo -e "\n${YELLOW}[Step 2/5]${NC} Installing Python dependencies..."

if [ -f "requirements-notebook.txt" ]; then
    echo -e "${GREEN}✓${NC} Found requirements-notebook.txt"
    pip install --upgrade pip setuptools wheel > /dev/null 2>&1
    pip install -r requirements-notebook.txt
    echo -e "${GREEN}✓${NC} Dependencies installed successfully"
else
    echo -e "${RED}✗${NC} requirements-notebook.txt not found!"
    echo "   Creating minimal requirements..."
    pip install openai pandas python-dotenv jupyter jupyterlab
    echo -e "${GREEN}✓${NC} Minimal dependencies installed"
fi

# ============================================================================
# Step 3: Verify PRODCOM data file
# ============================================================================
echo -e "\n${YELLOW}[Step 3/5]${NC} Verifying PRODCOM data file..."

PRODCOM_FILE="ClassifAI/input/prodcom_2023_classification.csv"

if [ -f "$PRODCOM_FILE" ]; then
    echo -e "${GREEN}✓${NC} PRODCOM file found: $PRODCOM_FILE"
    LINES=$(wc -l < "$PRODCOM_FILE")
    echo -e "${GREEN}✓${NC} File contains $LINES lines"
else
    echo -e "${YELLOW}!${NC} PRODCOM file not found at $PRODCOM_FILE"
    echo "   Make sure to upload the file or it will be needed to run the notebook"
fi

# ============================================================================
# Step 4: Create necessary directories
# ============================================================================
echo -e "\n${YELLOW}[Step 4/5]${NC} Creating necessary directories..."

mkdir -p ClassifAI/output
mkdir -p ClassifAI/logs
mkdir -p ClassifAI/img_temp

echo -e "${GREEN}✓${NC} Created output directory: ClassifAI/output"
echo -e "${GREEN}✓${NC} Created logs directory: ClassifAI/logs"
echo -e "${GREEN}✓${NC} Created temp image directory: ClassifAI/img_temp"

# ============================================================================
# Step 5: Display notebook information
# ============================================================================
echo -e "\n${YELLOW}[Step 5/5]${NC} Setup complete!"

echo -e "\n${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🎉 Environment Ready!                                          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Next steps:${NC}"
echo "  1. Open Jupyter by clicking the 'Open' button above"
echo "  2. Navigate to and open: notebooks/ClassifAI_notebook.ipynb"
echo "  3. Follow the notebook cells step by step"
echo "  4. Enter your OpenAI API Key when prompted (Step 3)"
echo ""
echo -e "${YELLOW}Important Notes:${NC}"
echo "  • The notebook includes sample products for quick testing"
echo "  • Each product classification costs ~\$0.01-0.02 (gpt-4o-mini)"
echo "  • Results are saved to: ClassifAI/output/"
echo "  • Logs are saved to: ClassifAI/logs/"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  • NOTEBOOK_README.md  - Detailed notebook documentation"
echo "  • ONYXIA_SETUP.md     - SSPCloud-specific instructions"
echo "  • README.md           - Full project documentation"
echo ""
echo -e "${GREEN}Helpful links:${NC}"
echo "  • OpenAI API: https://platform.openai.com/api-keys"
echo "  • Notebook help: https://jupyter.readthedocs.io/"
echo ""

# ============================================================================
# Optional: Launch Jupyter automatically (commented out)
# Uncomment the next line if you want Jupyter to start automatically
# ============================================================================
# echo -e "\n${YELLOW}[Optional]${NC} Starting Jupyter Lab..."
# jupyter lab --ip=0.0.0.0 --allow-root --no-browser

echo -e "${GREEN}Setup complete!${NC} You can now start working.\n"
