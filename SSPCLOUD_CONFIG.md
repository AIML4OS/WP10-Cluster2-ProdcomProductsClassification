# SSPCloud/Onyxia Configuration for PRODCOM Notebook

## Configuration Details for Launching on SSPCloud

This configuration describes how to set up the PRODCOM Classification Notebook on SSPCloud/Onyxia.

### Service: Jupyter Lab (Python)

**Settings to configure when launching:**

#### 1. Basic Information
- **Service Name**: `PRODCOM_Classification_Notebook` (or your preferred name)
- **Service Type**: Jupyter Lab
- **Description**: Interactive PRODCOM product classification using OpenAI

#### 2. Resource Allocation
- **CPU**: 2-4 cores (minimum 2)
- **RAM**: 4-8 GB (minimum 4 GB)
- **Storage**: At least 10 GB

#### 3. Git Repository Configuration
- **Repository URL**: `https://github.com/AIML4OS/WP10-Cluster2-ProdcomProductsClassification.git`
- **Branch**: `main` (or your working branch)

#### 4. Initialization Script
- **Init Script**: 
  ```bash
  /home/onyxia/work/WP10-Cluster2-ProdcomProductsClassification/sspcloud/init-notebook-trainees.sh
  ```
- This script will:
  - Install all required Python packages
  - Verify the PRODCOM data file
  - Create necessary output/log directories
  - Display setup completion message

#### 5. Environment Variables (Optional)
If you want to pre-configure the OpenAI API key:

```bash
OPENAI_API_KEY=sk-your-api-key-here
```

⚠️ **Security Note**: Never commit API keys to GitHub. Use SSPCloud's secrets management or prompt users to enter them in the notebook.

#### 6. Data Files
The repository already includes:
- `ClassifAI/input/prodcom_2023_classification.csv` - PRODCOM classification taxonomy
- Sample products in the notebook

If you need additional data:
- Place it in `ClassifAI/input/` before launching
- Or use SSPCloud's S3 storage (configure in "My data" section)

---

## Quick Launch Instructions

### For SSPCloud Users (Simple One-Click)

If you want to provide a pre-configured auto-launch link:

```
https://datalab.sspcloud.fr/launcher?service=jupyter&
repo=https://github.com/AIML4OS/WP10-Cluster2-ProdcomProductsClassification&
init-script=sspcloud/init-notebook-trainees.sh&
cpu=4&
mem=8
```

### For Manual Configuration

1. Go to SSPCloud DataLab: https://datalab.sspcloud.fr/
2. Click "My Services" → "Launch a New Service"
3. Select **Jupyter Lab** or **VSCode Python**
4. Fill in the settings above
5. Click "Launch"
6. Wait for the service to start
7. The init script will run automatically
8. Click "Open" to access Jupyter Lab
9. Open `notebooks/ClassifAI_notebook.ipynb`

---

## Alternative: Direct VSCode Launch

For developers who prefer VSCode with Jupyter support:

- **Service**: VSCode Python
- **Init Script**: Same as above (`sspcloud/init-notebook-trainees.sh`)
- **Advantages**: Better IDE features, Git integration, debugging tools

---

## File Structure Used by SSPCloud

```
Work Directory: /home/onyxia/work/
├── WP10-Cluster2-ProdcomProductsClassification/
│   ├── notebooks/
│   │   └── ClassifAI_notebook.ipynb      ← Main notebook to run
│   ├── requirements-notebook.txt          ← Python dependencies
│   ├── NOTEBOOK_README.md                 ← Notebook documentation
│   ├── ONYXIA_SETUP.md                    ← This file
│   ├── ClassifAI/
│   │   ├── input/
│   │   │   └── prodcom_2023_classification.csv
│   │   ├── output/                       ← Generated here
│   │   └── logs/                         ← Logs saved here
│   └── sspcloud/
│       └── init-notebook-trainees.sh     ← Init script
```

---

## Environment Information

### Python Version
- Recommended: Python 3.9 or 3.10
- Jupyter will automatically select available Python

### Pre-installed on SSPCloud
- Python 3.x
- Jupyter Lab
- pip, conda
- Common data science packages (pandas, numpy, etc.)

### Installation During Init Script
The script will install:
- openai (latest)
- pandas (latest)
- python-dotenv
- jupyter
- jupyterlab

---

## Troubleshooting

### Issue: Init script not found
**Solution**: Ensure the repository is cloned correctly. The full path should be:
```
/home/onyxia/work/WP10-Cluster2-ProdcomProductsClassification/sspcloud/init-notebook-trainees.sh
```

### Issue: Notebook not visible
**Solution**: 
1. Check that Jupyter Lab has loaded completely
2. Navigate to the repo folder in the file browser
3. Look for `ClassifAI_notebook.ipynb`

### Issue: Module not found errors
**Solution**: The init script may not have completed. 
1. Open Terminal in Jupyter
2. Run: `pip install -r requirements-notebook.txt`

### Issue: PRODCOM file not found
**Solution**:
1. The file should be at: `ClassifAI/input/prodcom_2023_classification.csv`
2. If missing, the notebook will show an error in Step 4
3. Upload the file to that location

### Issue: OpenAI API errors
**Solution**:
1. Check your API key is valid: https://platform.openai.com/api-keys
2. Ensure the key has sufficient credits
3. Check your organization's API usage limits

---

## Cost Estimation

Using **gpt-4o-mini** model:

| Products | Est. Tokens | Est. Cost |
|----------|-------------|-----------|
| 5 (sample) | 2,500-5,000 | $0.05-0.10 |
| 10 | 5,000-10,000 | $0.10-0.20 |
| 50 | 25,000-50,000 | $0.50-1.00 |
| 100 | 50,000-100,000 | $1.00-2.00 |

---

## Next Steps

1. **Test locally first**: Run `python -m jupyter lab` and open the notebook
2. **Configure on SSPCloud**: Use settings above
3. **Share the link**: Provide users with the auto-launch URL
4. **Gather feedback**: Collect issues and improve

---

## Additional Resources

- [SSPCloud Documentation](https://docs.sspcloud.fr/en/)
- [Jupyter Documentation](https://jupyter.readthedocs.io/)
- [OpenAI API Docs](https://platform.openai.com/docs/)
- [PRODCOM Classification](https://ec.europa.eu/eurostat/statistics-explained/index.php/PRODCOM)

---

**Last Updated**: 2026-08-28
**Version**: 1.0
