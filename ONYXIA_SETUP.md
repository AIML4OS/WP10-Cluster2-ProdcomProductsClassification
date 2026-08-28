# Onyxia Service Configuration for PRODCOM Classification Notebook

## Files Included

This directory contains everything needed to run the PRODCOM product classification notebook on Onyxia:

- **ClassifAI_notebook.ipynb** - Main Jupyter notebook (runnable)
- **NOTEBOOK_README.md** - Comprehensive documentation
- **requirements-notebook.txt** - Python dependencies
- **input/prodcom_2023_classification.csv** - PRODCOM classification data

## How to Deploy on Onyxia

### Method 1: Using Onyxia Jupyter Service

1. **Launch a Jupyter service** on your Onyxia instance:
   - Go to "My Services" → "Launch a New Service"
   - Select "Jupyter Lab" or "Jupyter Notebook"
   - Allocate resources (minimum: 2GB RAM, 1 CPU)
   - Click "Launch"

2. **Clone or upload this repository**:
   ```bash
   # In Jupyter terminal
   git clone https://github.com/AIML4OS/WP10-Cluster2-ProdcomProductsClassification.git
   cd WP10-Cluster2-ProdcomProductsClassification
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements-notebook.txt
   ```

4. **Open the notebook**:
   - Navigate to `notebooks/ClassifAI_notebook.ipynb` in Jupyter
   - Open and run cells sequentially

### Method 2: Direct Upload

1. **Upload to Onyxia**:
   - Go to Files → My Files
   - Upload `ClassifAI_notebook.ipynb`
   - Upload `input/prodcom_2023_classification.csv`

2. **Start Jupyter**:
   - Launch Jupyter service
   - Navigate to uploaded files
   - Open `ClassifAI_notebook.ipynb`

3. **Run the notebook** following the documented steps

## Environment Variables

To avoid entering the API key each time, set up environment variables:

```bash
# In Jupyter terminal or system
export OPENAI_API_KEY="sk-..."
```

Then modify Step 3 of the notebook to read from environment:

```python
import os
api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    api_key = getpass("Enter your OpenAI API Key: ")
```

## Sharing Results

Results are saved to `output/prodotti_classificati_notebook_TIMESTAMP.csv`

To share with team members:
1. Upload results to Onyxia shared storage
2. Share file link from Onyxia Files interface
3. Or export via S3 if configured

## Troubleshooting on Onyxia

### Issue: "File not found: prodcom_2023_classification.csv"
- **Solution**: Ensure file is in `input/` directory relative to notebook
- Or provide absolute path to file

### Issue: Module not found errors
- **Solution**: Run pip install in notebook terminal:
  ```bash
  !pip install -r requirements-notebook.txt
  ```

### Issue: Out of memory
- **Solution**: Increase RAM allocation when launching service

### Issue: Timeout on long-running cells
- **Solution**: This is expected for large datasets; wait for completion

## Performance Notes

- **Small datasets (1-10 products)**: ~2-5 minutes
- **Medium datasets (10-50 products)**: ~10-30 minutes
- **Large datasets (50+ products)**: 30 minutes to hours

Each product requires ~7 API calls (one per hierarchy level).

## Customization for Onyxia

To adapt for Onyxia environment:

1. **Adjust paths** in Step 3:
   ```python
   config.PRODCOM_FILE = "/shared-data/prodcom_2023_classification.csv"
   config.OUTPUT_DIR = "/shared-data/output"
   ```

2. **Use Onyxia secrets** for API keys:
   - Store API key in Onyxia secrets
   - Retrieve in notebook via environment variables

3. **Mount shared storage**:
   - If using NFS or S3
   - Configure paths accordingly

## Cost Estimation

**OpenAI API Costs** (using gpt-4o-mini):

| Products | Estimated Tokens | Est. Cost |
|----------|------------------|-----------|
| 5 | 2,500-5,000 | $0.05-0.10 |
| 10 | 5,000-10,000 | $0.10-0.20 |
| 50 | 25,000-50,000 | $0.50-1.00 |
| 100 | 50,000-100,000 | $1.00-2.00 |

Prices vary based on:
- Description length
- Model used (gpt-3.5-turbo is cheaper)
- Current OpenAI pricing

## Next Steps

1. **Test with sample data** (included in notebook)
2. **Customize for your products** (see NOTEBOOK_README.md)
3. **Run classification**
4. **Review and validate results**
5. **Export and share results**

## Support

For more information:
- Read NOTEBOOK_README.md
- Check OpenAI API documentation
- See main project documentation

---

**Onyxia Integration**: Ready for SSPCloud deployment
