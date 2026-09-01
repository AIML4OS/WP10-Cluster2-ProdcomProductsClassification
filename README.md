# <img height="18" width="18" src="https://cdn.simpleicons.org/python/00ccff99" /> ClassifAI – Automatic Prodcom Product Classification

ClassifAI is an automatic product classification system developed within the **AIML4OS WP10 project**. It uses semantic search, vector embeddings, **Qdrant**, and **OpenAI** models to automatically classify products according to the **PRODCOM statistical product classification**.

This repository contains both the **ClassifAI software** and the **AIML4OS training material** used to document and demonstrate the methodology.

## Overview

ClassifAI processes product information collected from company websites and produces an automatic PRODCOM classification.

Depending on the available information, a product can be represented through:

* product name;
* product description;
* product URL;
* product image;
* additional metadata.

The system can generate a synthetic product description using an LLM and then identify the most appropriate PRODCOM code.

The classification workflow combines **semantic vector search** with **large language models**, allowing different classification strategies to be used depending on the desired trade-off between speed and accuracy.

## Try the Notebook in Onyxia! 🚀

If you have an Onyxia account and an OpenAI API key, you can try out one of the various classification methods supported by the project directly by [**clicking here.**](https://datalab.sspcloud.fr/launcher/ide/jupyter-python?name=ProdcomProductClassification&version=2.5.2&s3=default&service.image.version=«inseefrlab%2Fonyxia-jupyter-python%3Apy3.12.13»&init.personalInit=«https%3A%2F%2Fraw.githubusercontent.com%2FAIML4OS%2FWP10-Cluster2-ProdcomProductsClassification%2Frefs%2Fheads%2Fmain%2Fsspcloud%2Finit-trainees.sh»&init.personalInitArgs=«notebooks%2FClassifAI_notebook.ipynb»&git.repository=«https%3A%2F%2Fgithub.com%2FAIML4OS%2FWP10-Cluster2-ProdcomProductsClassification.git»&git.branch=«main»&git.asCodeServerRoot=true&networking.user.enabled=true&autoLaunch=true)

## Quick Start: Try the Notebook! 

For a quick, reproducible demonstration without complex setup, try the **standalone Jupyter notebook**:

```bash
# 1. Clone the repository
git clone https://github.com/AIML4OS/WP10-Cluster2-ProdcomProductsClassification.git
cd WP10-Cluster2-ProdcomProductsClassification

# 2. Install dependencies
pip install -r requirements-notebook.txt

# 3. Open the notebook
jupyter notebook notebooks/ClassifAI_notebook.ipynb

# 4. Run cells sequentially and enter your OpenAI API Key when prompted
```

**Benefits:**
- ✅ No Qdrant required
- ✅ Simple one-click setup
- ✅ Sample products included
- ✅ Perfect for testing and demos
- ✅ Runnable on Onyxia/SSPCloud

📖 **See [NOTEBOOK_README.md](NOTEBOOK_README.md)** for detailed instructions and [ONYXIA_SETUP.md](ONYXIA_SETUP.md) for cloud deployment.

## Main Features

* **Semantic classification** using vector embeddings and Qdrant.
* **Multimodal processing** of text, images and product URLs.
* **Hierarchical classification** based on the PRODCOM structure.
* **LLM-generated product descriptions**.
* **Four classification strategies**, ranging from vector search only to recursive LLM-based classification.
* **Batch processing** of multiple products.
* **Configurable classification parameters**.
* **Logging** of the classification process.

## Classification Strategies

ClassifAI currently supports four classification strategies:

| Strategy                                 | ID | Description                                                                                          |
| ---------------------------------------- | -: | ---------------------------------------------------------------------------------------------------- |
| **Qdrant only**                          |  1 | Uses semantic similarity to retrieve the most similar PRODCOM code.                                  |
| **Qdrant + OpenAI**                      |  2 | Retrieves the most similar candidates from Qdrant and uses OpenAI to select the best classification. |
| **OpenAI recursive**                     |  3 | Uses OpenAI to recursively navigate the PRODCOM hierarchy.                                           |
| **OpenAI recursive without description** |  4 | Same recursive approach without generating an LLM-based product description.                         |

Strategies 2 and 3 generally provide the best balance between classification quality and execution time.

## Repository Structure

The repository follows the **AIML4OS Quarto Python template** and combines the training material with the ClassifAI software.

```text
WP10-Cluster2-ProdcomProductsClassification/
│
├── ClassifAI/                 # ClassifAI source code
│   ├── _1_list_page_products.py
│   ├── _2_json_2_csv.py
│   ├── _3_qdrant_populate_prodcom.py
│   ├── _4_create_and_save_qdrant_collection_snapshot.py
│   ├── _5_restore_qdrant_collection_from_snapshot.py
│   ├── _7_classifai.py
│   ├── classif_qdrant_only.py
│   ├── classif_qdrant_openai.py
│   ├── classif_openai.py
│   ├── classif_openai_no_descr.py
│   ├── context.py
│   └── classifai_cfg.ini
│
├── chapters/                  # Quarto training material
├── notebooks/                 # Jupyter notebooks
├── resources/                 # Images and other resources
├── sspcloud/                  # SSPCloud configuration
├── images/                    # Repository images
│
├── index.qmd                  # Main Quarto page
├── _quarto.yml                # Quarto configuration
├── pyproject.toml             # Python project and dependency configuration
├── uv.lock                    # Locked Python dependencies
└── README.md                  # Project documentation
```

## Requirements

The project requires:

* **Python 3.10 or later**;
* access to a **Qdrant** instance;
* an **OpenAI API key**;
* access to the required product and PRODCOM data.

The repository is designed to be used within the **AIML4OS / SSPCloud environment**. Python dependencies are managed through the project configuration and `uv`.

## Installation

Clone the repository and install the Python dependencies using the project configuration.

For the standard ClassifAI functionality:

```bash
uv sync
```

The scraping functionality requires the optional scraping dependencies:

```bash
uv sync --extra scraping
```

The scraping workflow uses Playwright. When required, install the Chromium browser:

```bash
playwright install chromium
```

## Configuration

ClassifAI requires credentials for the external services used during classification.

The main environment variables are:

```ini
QDRANT_URL=your_qdrant_url
QDRANT_API_KEY=your_qdrant_api_key
OPENAI_API_KEY=your_openai_api_key
```

These values must be provided through the execution environment or through an appropriate local `.env` configuration.

**Never commit API keys or other sensitive credentials to the repository.**

Additional ClassifAI parameters are defined in:

```text
ClassifAI/classifai_cfg.ini
```

The configuration includes, among other parameters:

* input and output paths;
* Qdrant collection name;
* number of candidates retrieved from Qdrant;
* OpenAI model;
* embedding model;
* image processing mode;
* classification strategy;
* delay between processed products.

## Input Data

The main classification workflow expects a tab-separated CSV file containing product information.

The expected fields include:

```text
name
description
id
domain
product_url
product_img_url
source_file
```

The product description, URL and image information can be used by the different classification strategies depending on the selected configuration.

## Output

The classification process produces information including:

```text
name
description
id
domain
product_url
product_img_url
source_file
code_type
parent
generated_description
code
code_description
```

The resulting `code` and `code_description` correspond to the automatically selected PRODCOM classification.

## Data Preparation

The repository also contains scripts supporting the preparation of product data.

### Product extraction

`_1_list_page_products.py`

Extracts product information from web pages using ScrapeGraphAI and stores the results in JSON format.

### JSON to CSV conversion

`_2_json_2_csv.py`

Converts the product information extracted in JSON format into a CSV file suitable for the classification workflow.

## Qdrant Collection Management

Qdrant is used as the vector database for the semantic retrieval of PRODCOM candidates.

The repository provides utilities for managing the PRODCOM collection:

| Script                                             | Purpose                                            |
| -------------------------------------------------- | -------------------------------------------------- |
| `_3_qdrant_populate_prodcom.py`                    | Populates Qdrant with PRODCOM classification data. |
| `_4_create_and_save_qdrant_collection_snapshot.py` | Creates a snapshot of a Qdrant collection.         |
| `_5_restore_qdrant_collection_from_snapshot.py`    | Restores a Qdrant collection from a snapshot.      |

Snapshots can be used to reproduce or transfer a prepared PRODCOM Qdrant collection between environments.

## Running ClassifAI

The main classification script is:

```text
ClassifAI/_7_classifai.py
```

Once the environment and configuration have been prepared, the classification workflow can be launched from the project environment.

The selected classification strategy is controlled through:

```ini
classif_strategy = 2
```

in `ClassifAI/classifai_cfg.ini`.

## Logging

ClassifAI records the execution process both in the console and in log files.

Log files follow the naming convention:

```text
logs/log_classifai_YYYY-MM-DD_HH_MM_SS.log
```

The logging system records general information, warnings, errors and exceptions, including stack traces when appropriate.

## Troubleshooting

### Qdrant API errors

ClassifAI uses the Qdrant `query_points` API. The project currently specifies a compatible `qdrant-client` version in the Python project configuration.

If Qdrant-related errors occur, first verify that:

* the configured Qdrant URL is correct;
* the API key is valid;
* the expected Qdrant collection exists;
* the installed `qdrant-client` version is compatible with the project.

### Missing credentials

If `QDRANT_URL`, `QDRANT_API_KEY` or `OPENAI_API_KEY` cannot be found, verify that the required environment variables have been correctly configured in the execution environment.

### OpenAI rate limits

If OpenAI rate limits are encountered, increase the delay between products through:

```ini
sleep_secs_between_products
```

in `ClassifAI/classifai_cfg.ini`.

### Incorrect classifications

Different classification strategies can produce different results. If classification quality is not satisfactory, compare strategies 2 and 3 and review the generated product description and retrieved Qdrant candidates.

### Web scraping timeouts

Some websites may be slow or may block automated browsers. Verify that the target website is accessible and, when necessary, adjust the scraping configuration.

## Training Material

The repository is structured according to the **AIML4OS training material template** and uses **Quarto** to provide documentation and training material around the ClassifAI workflow.

The training material is progressively organized in the `chapters/` and `notebooks/` directories.

For information on how AIML4OS training repositories are structured, developed and deployed, see the:

[**AIML4OS Training Material Starting Pack**](https://aiml4os.github.io/training-material-starting-pack/)

## AIML4OS and WP10

This work is part of **AIML4OS WP10 – Cluster 2**, focusing on the automatic classification of products according to the PRODCOM classification.

The repository combines:

1. the ClassifAI classification software;
2. the data preparation and vector-search components;
3. the Quarto-based training material;
4. the configuration required to use the project in the AIML4OS / SSPCloud ecosystem.

## License and Attribution

This is a research project developed within the AIML4OS initiative for the integration of artificial intelligence and machine learning methods into statistical production processes.

For questions, issues or contributions, please use the GitHub repository issue tracker.

## Usage
This repository provides a clean and modular template to build tutorials for projects in the **AIML4OS** project.
➡️ See [this tutorial](https://aiml4os.github.io/training-material-starting-pack/) on how to customize and deploy this template.
