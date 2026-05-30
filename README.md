# Walmart Sales Data Analysis

An end-to-end data analysis project that loads Walmart retail transaction data into PostgreSQL using Python, then answers key business questions through SQL.

## Project Overview

This project follows a full ETL + analysis pipeline:

1. Load raw CSV data into a Pandas DataFrame
2. Clean and transform the data (type casting, null removal, feature engineering)
3. Push the cleaned data to a PostgreSQL database via SQLAlchemy
4. Run SQL queries to extract business insights

## Dataset

**File:** `Walmart.csv`  
**Records:** ~10,051 transactions across multiple US Walmart branches  
**Columns:**

| Column | Description |
|---|---|
| `invoice_id` | Unique transaction identifier |
| `branch` | Walmart branch code (e.g. WALM003) |
| `city` | City where the branch is located |
| `category` | Product category (e.g. Health and beauty, Electronics) |
| `unit_price` | Price per item |
| `quantity` | Number of items purchased |
| `date` | Transaction date (DD/MM/YY) |
| `time` | Transaction time |
| `payment_method` | Payment type: Cash, Ewallet, or Credit card |
| `rating` | Customer satisfaction rating |
| `profit_margin` | Profit margin as a decimal |
| `total` | Derived column — `unit_price × quantity` |

## Project Structure

```
.
├── Walmart.csv          # Raw sales data
├── project.ipynb        # Jupyter notebook: data cleaning & DB loading
├── walmart.sql          # SQL queries for business analysis
├── requirements.txt     # Python dependencies
└── README.md
```

## Setup & Installation

**Prerequisites:** Python 3.11+, PostgreSQL

1. Clone the repository and navigate to the project folder.

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Create a PostgreSQL database:
   ```sql
   CREATE DATABASE walmart_db;
   ```

4. Update the connection string in `project.ipynb` with your credentials:
   ```python
   engine_psql = create_engine("postgresql+psycopg2://postgres:your_password@localhost:5432/walmart_db")
   ```

5. Run all cells in `project.ipynb` to clean the data and load it into PostgreSQL.

6. Open `walmart.sql` in your SQL client and run the queries.

## Data Cleaning Steps (Notebook)

- Removed duplicate and null rows (~82 records dropped)
- Stripped currency symbols from `unit_price` and cast to `float64`
- Standardized all column names to lowercase
- Engineered a `total` column (`unit_price × quantity`)
- Loaded the cleaned DataFrame into PostgreSQL using `df.to_sql()`

## Business Questions Answered (SQL)

1. **Transactions & quantity by payment method** — How many transactions and items sold per payment type?
2. **Highest-rated category per branch** — Which product category earns the best average rating at each branch?
3. **Busiest day per branch** — Which day of the week sees the most transactions at each branch?
4. **Total quantity sold per payment method** — Aggregate item volume broken down by how customers pay.
5. **Rating statistics by city & category** — Min, max, and average customer ratings across city/category combinations.
6. **Total profit by category** — Profit calculated as `unit_price × quantity × profit_margin`, ranked highest to lowest.
7. **Most common payment method per branch** — Which payment method dominates at each branch?

## Dependencies

```
pandas
pymysql
sqlalchemy
psycopg2-binary
```