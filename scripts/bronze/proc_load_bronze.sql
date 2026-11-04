/*
=============================================================
Stored Procedure: Load Bronze Layer (Raw Ingestion)
=============================================================
Script Purpose:
    Loads raw e-commerce data from flat files into the Bronze schema.
    
Execution Flow:
    1. Truncates all target tables (ensures idempotent full reload).
    2. Performs BULK INSERT using a custom delimiter ('{') and UTF-8 encoding.
    3. Tracks and prints execution runtime for each table and total batch.
    4. Handles runtime exceptions gracefully using a TRY...CATCH block.

Parameters:
    None.

Usage:
    EXEC bronze.load_bronze;
=============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    

    -- Track per-table and total batch execution runtimes
    DECLARE 
        @start_time       DATETIME, 
        @end_time         DATETIME, 
        @batch_start_time DATETIME, 
        @batch_end_time   DATETIME;

    BEGIN TRY  
        PRINT '=============================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '=============================================================';
        
        SET @batch_start_time = GETDATE();

        -- -------------------------------------------------------------
        -- 1. Load: bronze.customers
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.customers';
        TRUNCATE TABLE bronze.customers;

        PRINT '>> Inserting Data Into: bronze.customers';
        BULK INSERT bronze.customers
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_customers_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 2. Load: bronze.geolocation
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.geolocation';
        TRUNCATE TABLE bronze.geolocation;

        PRINT '>> Inserting Data Into: bronze.geolocation';
        BULK INSERT bronze.geolocation
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_geolocation_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 3. Load: bronze.order_items
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.order_items';
        TRUNCATE TABLE bronze.order_items;

        PRINT '>> Inserting Data Into: bronze.order_items';
        BULK INSERT bronze.order_items
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_order_items_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 4. Load: bronze.order_payments
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.order_payments';
        TRUNCATE TABLE bronze.order_payments;

        PRINT '>> Inserting Data Into: bronze.order_payments';
        BULK INSERT bronze.order_payments
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_order_payments_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 5. Load: bronze.order_reviews
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.order_reviews';
        TRUNCATE TABLE bronze.order_reviews;

        PRINT '>> Inserting Data Into: bronze.order_reviews';
        BULK INSERT bronze.order_reviews
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_order_reviews_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 6. Load: bronze.orders
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.orders';
        TRUNCATE TABLE bronze.orders;

        PRINT '>> Inserting Data Into: bronze.orders';
        BULK INSERT bronze.orders
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_orders_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 7. Load: bronze.products
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.products';
        TRUNCATE TABLE bronze.products;

        PRINT '>> Inserting Data Into: bronze.products';
        BULK INSERT bronze.products
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_products_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 8. Load: bronze.sellers
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.sellers';
        TRUNCATE TABLE bronze.sellers;

        PRINT '>> Inserting Data Into: bronze.sellers';
        BULK INSERT bronze.sellers
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\olist_sellers_dataset_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- 9. Load: bronze.product_category_translation
        -- -------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.product_category_translation';
        TRUNCATE TABLE bronze.product_category_translation;

        PRINT '>> Inserting Data Into: bronze.product_category_translation';
        BULK INSERT bronze.product_category_translation
        FROM 'D:\SQLcourse\Brazilian E-Commerce Public Dataset by Olist\olist_clean_files\product_category_name_translation_delim.txt'
        WITH (
            FIRSTROW        = 2, 
            FIELDTERMINATOR = '{', 
            ROWTERMINATOR   = '0x0a', 
            CODEPAGE        = '65001', 
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- -------------------------------------------------------------
        -- Batch Summary
        -- -------------------------------------------------------------
        SET @batch_end_time = GETDATE();
        PRINT '=============================================================';
        PRINT 'Loading Bronze Layer Completed Successfully!';
        PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '=============================================================';

    END TRY 
    BEGIN CATCH 
        PRINT '=============================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Line   : ' + CAST(ERROR_LINE() AS NVARCHAR);
        PRINT '=============================================================';
    END CATCH
END;
GO
