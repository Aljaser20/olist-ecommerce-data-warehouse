 # olist-ecommerce-data-warehouse
An End-to-End Modern Data Warehouse and ETL solution built with SQL Server using Medallion Architecture (Bronze, Silver, Gold layers) and Kimball Dimensional Modeling (Star Schema) to deliver business-ready analytics


 --
 # Modern SQL Data Warehouse & ETL Pipeline (Medallion Architecture)

## 📌 Project Overview
This repository contains an end-to-end Data Warehouse solution built with **SQL Server** using the **Medallion Architecture (Bronze, Silver, Gold)**. 

The primary business objective is to resolve operational data silos by consolidating, cleansing, and transforming disconnected transaction data from two distinct legacy sources:
1. **CRM System:** Managing customer profiles, product catalog, and transaction orders.
2. **ERP System:** Managing customer demographics, geographical locations, and product classifications.

The final deliverable is an optimized, analytics-ready **Star Schema** dimensional model serving customer and product performance insights.

---

## 🏗️ Data Architecture (Medallion Pattern)
[ Source CSVs: CRM & ERP Systems ]
                   │
                   ▼  BULK INSERT / Staging
    [ 01_Bronze: Raw Ingestion Layer ]
                   │
                   ▼  Data Cleansing & Normalization (Stored Procedures)
   [ 02_Silver: Standardized Layer ]
                   │
                   ▼  Kimball Modeling & Surrogate Keys (SQL Views)
     [ 03_Gold: Star Schema Views ]
                   │
                   ▼
   [ 04_Analytics: KPIs & Business Insights ]


   * **Bronze Layer (Raw):** Stores ingested data in staging tables matching the source schema without constraints[cite: 1].
* **Silver Layer (Clean):** Performs schema casting, trims whitespace, standardizes invalid dates, removes duplicates, and handles missing attributes using `COALESCE` and `CASE WHEN` logic.
* **Gold Layer (Analytics):** Business-ready dimensional model featuring surrogate keys generated via analytical window functions (`ROW_NUMBER() OVER (...)`)[cite: 1, 3].

---

## 📐 Data Modeling (Gold Layer / Star Schema)

The analytical layer consists of Kimball-style Dimension and Fact structures implemented as views[cite: 1, 3]:

* **`gold.dim_customers`:** Consolidated customer dimension integrating CRM identity with ERP geographic and demographic data (`LOC_A101`, `CUST_AZ12`)[cite: 1, 3].
* **`gold.dim_products`:** Product dimension enriched with ERP categories (`PX_CAT_G1V2`), filtering out historical versions (`WHERE prd_end_dt IS NULL`).
* **`gold.fact_sales`:** Central transactional fact table mapping line-item orders to customer and product dimensions via surrogate keys[cite: 1, 3].

---

## 📂 Repository Structure

```text
├── 00_setup/
│   └── init_database.sql          # Database initialization & schema creation (bronze, silver, gold)
├── 01_bronze/
│   ├── ddl_bronze.sql             # Raw staging tables definitions
│   └── proc_load_bronze.sql       # Automated BULK INSERT stored procedures
├── 02_silver/
│   ├── ddl_silver.sql             # Standardized tables definitions
│   └── proc_load_silver.sql       # Cleansing & deduplication pipelines
├── 03_gold/
│   └── ddl_gold_views.sql         # Star schema views (dim_customers, dim_products, fact_sales)
├── 04_analytics/
│   └── analytics_queries.sql      # Business metrics & KPI queries (Window functions, trends)
└── README.md


🚀 How to Run the Pipeline
  Initialize Database & Schemas:
    Execute 00_setup/init_database.sql to generate the database container and security schemas (bronze, silver, gold).

  Setup Staging & Ingestion:
    Run 01_bronze/ddl_bronze.sql, update CSV source paths in 01_bronze/proc_load_bronze.sql, and execute the procedure: EXEC bronze.load_bronze;
  Execute Cleansing Pipeline:
    Run 02_silver/ddl_silver.sql followed by 02_silver/proc_load_silver.sql: EXEC silver.load_silver;
  Deploy Dimensional Views:
    Run 03_gold/ddl_gold_views.sql to expose the analytical data marts[cite: 3].

🛠️ Technical Skills Demonstrated
 *   Database Engine: Microsoft SQL Server / T-SQL
 *  Architecture: Medallion Architecture (Bronze $\to$ Silver $\to$ Gold)[cite: 1]
 * Data Modeling: Kimball Dimensional Modeling (Fact & Dimension Tables, Star Schema)[cite: 1, 3]
 *   SQL Transformations: Window Functions (ROW_NUMBER), Common Table Expressions (CTEs), COALESCE, CASE WHEN, Multi-table Joins[cite: 1, 3]
 *    ETL/ELT Engineering: Idempotent Stored Procedures, Error Logging, and Bulk Ingestion[cite: 1]



