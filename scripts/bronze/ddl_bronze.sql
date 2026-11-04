/*
=============================================================
DDL Script: Create Bronze Tables (Raw Staging Layer)
=============================================================
Script Purpose:
    This script defines the raw staging tables in the 'bronze' schema
    for the Brazilian E-Commerce (Olist) dataset.

Design Considerations:
    - Tables are dropped and recreated to support idempotent executions.
    - All attributes use flexible Unicode text types (NVARCHAR) to ingest
      unstandardized source data without type-conversion failures.
    - Source field names and typos (e.g., 'lenght') are preserved intact 
      to maintain 1:1 lineage with source flat files.
=============================================================
*/

USE OlistDWH;
GO

-- =============================================================
-- Table: bronze.customers
-- =============================================================
IF OBJECT_ID('bronze.customers', 'U') IS NOT NULL
    DROP TABLE bronze.customers;
GO

CREATE TABLE bronze.customers (
    customer_id                 NVARCHAR(50),
    customer_unique_id          NVARCHAR(50),
    customer_zip_code_prefix    NVARCHAR(50),
    customer_city               NVARCHAR(100),
    customer_state              NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.geolocation
-- =============================================================
IF OBJECT_ID('bronze.geolocation', 'U') IS NOT NULL
    DROP TABLE bronze.geolocation;
GO

CREATE TABLE bronze.geolocation (
    geolocation_zip_code_prefix NVARCHAR(50),
    geolocation_lat             NVARCHAR(50),
    geolocation_lng             NVARCHAR(50),
    geolocation_city            NVARCHAR(100),
    geolocation_state           NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.order_items
-- =============================================================
IF OBJECT_ID('bronze.order_items', 'U') IS NOT NULL
    DROP TABLE bronze.order_items;
GO

CREATE TABLE bronze.order_items (
    order_id                    NVARCHAR(50),
    order_item_id               NVARCHAR(20),
    product_id                  NVARCHAR(50),
    seller_id                   NVARCHAR(50),
    shipping_limit_date         NVARCHAR(50),
    price                       NVARCHAR(50),
    freight_value               NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.order_payments
-- =============================================================
IF OBJECT_ID('bronze.order_payments', 'U') IS NOT NULL
    DROP TABLE bronze.order_payments;
GO

CREATE TABLE bronze.order_payments (
    order_id                    NVARCHAR(50),
    payment_sequential          NVARCHAR(20),
    payment_type                NVARCHAR(50),
    payment_installments        NVARCHAR(20),
    payment_value               NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.order_reviews
-- =============================================================
IF OBJECT_ID('bronze.order_reviews', 'U') IS NOT NULL
    DROP TABLE bronze.order_reviews;
GO

CREATE TABLE bronze.order_reviews (
    review_id                   NVARCHAR(50),
    order_id                    NVARCHAR(50),
    review_score                NVARCHAR(20),
    review_comment_title        NVARCHAR(200),
    -- MAX handles unstructured multiline customer feedback
    review_comment_message      NVARCHAR(MAX),
    review_creation_date        NVARCHAR(50),
    review_answer_timestamp     NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.orders
-- =============================================================
IF OBJECT_ID('bronze.orders', 'U') IS NOT NULL
    DROP TABLE bronze.orders;
GO

CREATE TABLE bronze.orders (
    order_id                        NVARCHAR(50),
    customer_id                     NVARCHAR(50),
    order_status                    NVARCHAR(50),
    order_purchase_timestamp        NVARCHAR(50),
    order_approved_at               NVARCHAR(50),
    order_delivered_carrier_date    NVARCHAR(50),
    order_delivered_customer_date   NVARCHAR(50),
    order_estimated_delivery_date   NVARCHAR(50)
);
GO

-- =============================================================
-- Table: bronze.products
-- =============================================================
IF OBJECT_ID('bronze.products', 'U') IS NOT NULL
    DROP TABLE bronze.products;
GO

CREATE TABLE bronze.products (
    product_id                  NVARCHAR(50),
    product_category_name       NVARCHAR(100),
    -- Retained source typo 'lenght' for exact raw metadata alignment
    product_name_lenght         NVARCHAR(20),
    product_description_lenght  NVARCHAR(20),
    product_photos_qty          NVARCHAR(20),
    product_weight_g            NVARCHAR(20),
    product_length_cm           NVARCHAR(20),
    product_height_cm           NVARCHAR(20),
    product_width_cm            NVARCHAR(20)
);
GO

-- =============================================================
-- Table: bronze.sellers
-- =============================================================
IF OBJECT_ID('bronze.sellers', 'U') IS NOT NULL
    DROP TABLE bronze.sellers;
GO

CREATE TABLE bronze.sellers (
    seller_id                   NVARCHAR(50),
    seller_zip_code_prefix      NVARCHAR(20),
    seller_city                 NVARCHAR(100),
    seller_state                NVARCHAR(20)
);
GO

-- =============================================================
-- Table: bronze.product_category_translation
-- =============================================================
IF OBJECT_ID('bronze.product_category_translation', 'U') IS NOT NULL
    DROP TABLE bronze.product_category_translation;
GO

CREATE TABLE bronze.product_category_translation (
    product_category_name           NVARCHAR(100),
    product_category_name_english   NVARCHAR(100)
);
GO
