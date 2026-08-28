# ClassifAI Product Classification Notebook

A self-contained Jupyter notebook for classifying products using the PRODCOM classification system powered by OpenAI.

## Overview

This notebook provides a simplified, runnable demonstration of the product classification system without requiring Qdrant or complex setup. It:

- Uses **OpenAI's language models** to classify products through the PRODCOM hierarchy
- **Requires only** the PRODCOM classification CSV file and an OpenAI API Key
- **Includes sample products** to demonstrate the workflow
- **Generates output** in CSV format
- **Runs on any system** with Python and Jupyter

## Prerequisites

- **Python 3.8+**
- **Jupyter Notebook** or **JupyterLab**
- **OpenAI API Key** (free trial or paid account)
- **PRODCOM classification file** (`prodcom_2023_classification.csv`)

## Quick Start

### Option 1: Local Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AIML4OS/WP10-Cluster2-ProdcomProductsClassification.git
   cd WP10-Cluster2-ProdcomProductsClassification
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements-notebook.txt
   ```

3. **Open the notebook**
   ```bash
   jupyter notebook notebooks/ClassifAI_notebook.ipynb
   ```

4. **Run the notebook**
   - Follow the cells step by step
   - When prompted, enter your OpenAI API Key
   - The notebook will classify the sample products

### Option 2: Google Colab

1. Upload the notebook to Google Colab
2. Ensure `prodcom_2023_classification.csv` is available (upload or mount Drive)
3. Update the file path in Step 4 if needed
4. Run the cells sequentially

### Option 3: Onyxia Service

This notebook can be deployed on Onyxia as a runnable service:

1. Upload to your Onyxia instance
2. Provide the PRODCOM CSV file in the service's shared storage
3. Users will be prompted for their OpenAI API Key

## Notebook Structure

| Step | Description |
|------|-------------|
| 1 | Install required Python packages |
| 2 | Import libraries |
| 3 | Setup configuration and API authentication |
| 4 | Load PRODCOM classification data |
| 5 | Define utility functions for data manipulation |
| 6 | Define OpenAI classification functions |
| 7 | Create sample products |
| 8 | Classify products through the PRODCOM hierarchy |
| 9 | Display and save results to CSV |

## How Classification Works

The system navigates through the PRODCOM hierarchy using OpenAI:

```
Product Description
        ↓
    SECTION (16 options)
        ↓
    DIVISION (58 options)
        ↓
    GROUP (244 options)
        ↓
    CLASS (615 options)
        ↓
    CPA5 (2,216 options)
        ↓
    CPA6 (3,500+ options)
        ↓
    PRODCOM (4,000+ codes)
```

At each level, the system uses OpenAI to select the most appropriate code based on the product description.

## Using Your Own Products

To classify your own products:

1. **Prepare product data** with these fields:
   - `name`: Product name
   - `description`: Detailed product description (important for accuracy)
   - `id`: Product identifier
   - `domain`: Source domain
   - `product_url`: Product URL
   - `product_img_url`: Product image URL (optional)
   - `source_file`: Source file reference

2. **Replace the sample data** in Step 7:
   ```python
   sample_products = [
       {
           "name": "Your Product Name",
           "description": "Your detailed product description...",
           # ... other fields
       },
       # Add more products
   ]
   ```

3. **Run the classification cells** (Steps 8-9)

## Configuration

Edit the `Config` class in Step 3 to customize:

```python
class Config:
    OPENAI_MODEL = "gpt-4o-mini"  # Model to use
    TEMPERATURE = 0.0              # Deterministic (0.0) or creative (higher)
    SLEEP_BETWEEN_PRODUCTS = 0.1   # Delay between API calls
    MAX_RETRIES = 5                # Retry attempts on rate limit
    PRODCOM_FILE = "./input/prodcom_2023_classification.csv"
    OUTPUT_DIR = "./output"
    OUTPUT_FILE_NAME = "prodotti_classificati_notebook"
```

## Output

The notebook generates:

1. **Console output** with:
   - Progress indicators
   - Classification details for each product
   - Error messages (if any)

2. **CSV file** containing:
   - Original product fields
   - Classification results (`code`, `code_description`, `code_type`)
   - Timestamp in filename

Example output file: `output/prodotti_classificati_notebook_2024-01-15_10_30_45.csv`

## API Costs

- **Model**: gpt-4o-mini (economical)
- **Average tokens per product**: ~500-1000 tokens
- **Cost estimate**: ~$0.01-0.02 per product (varies with description length)

To reduce costs:
- Use shorter, focused product descriptions
- Use `gpt-3.5-turbo` (if available and cheaper)
- Batch process products to optimize token usage

## Troubleshooting

### "File not found: prodcom_2023_classification.csv"
- Update the `PRODCOM_FILE` path in Step 3
- Ensure the file exists at the specified location
- Use absolute paths if relative paths don't work

### "OpenAI API Key is required!"
- Enter your API key when prompted
- Ensure the key is valid and has sufficient credits
- Check API key permissions on OpenAI dashboard

### Rate limit errors (429)
- The notebook automatically retries with exponential backoff
- Increase `SLEEP_BETWEEN_PRODUCTS` in configuration
- Consider using a different API key or waiting

### Poor classification results
- Ensure product descriptions are detailed and descriptive
- Avoid empty or very short descriptions
- Products with vague descriptions may be misclassified
- Review output and adjust descriptions if needed

## API Key Security

⚠️ **Important**: The API key is entered as plain text. For production:

1. Use environment variables:
   ```python
   api_key = os.getenv("OPENAI_API_KEY")
   ```

2. Or use a `.env` file:
   ```bash
   pip install python-dotenv
   # Add to notebook
   from dotenv import load_dotenv
   load_dotenv()
   api_key = os.getenv("OPENAI_API_KEY")
   ```

3. Never commit API keys to version control

## Limitations

- **No offline classification**: Requires OpenAI API access
- **No image processing**: Images are not analyzed (optional enhancement)
- **No Qdrant fallback**: Unlike the full system, this notebook uses only OpenAI
- **API dependencies**: Subject to OpenAI API availability and pricing

## Comparison with Full System

| Feature | Notebook | Full System |
|---------|----------|-------------|
| Requires Qdrant | ❌ No | ✅ Yes |
| Uses OpenAI | ✅ Yes | ✅ Yes (optional) |
| Simpler setup | ✅ Yes | ❌ Complex |
| Easier to demo | ✅ Yes | ❌ Not ideal for demos |
| Production-ready | ⚠️ Limited | ✅ Yes |
| Reproducible on Onyxia | ✅ Yes | ⚠️ With setup |

## Support

For issues or questions:
1. Check the **Troubleshooting** section
2. Review OpenAI API documentation
3. Check PRODCOM data format
4. See full system documentation

## License

This notebook is part of the WP10 project. See main repository for license details.

## Authors

- Created as part of WP10 - Cluster 2 - PRODCOM Products Classification

---

**Last Updated**: 2024
