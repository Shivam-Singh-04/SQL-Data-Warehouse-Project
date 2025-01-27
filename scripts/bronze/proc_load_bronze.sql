/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=============================================================';

		PRINT '-------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.crm_cust_info;

		-- Bulk Insert data in crm_cust_info table

		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.crm_prd_info;

		-- Bulk Insert data in crm_prd_info table
		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.crm_sales_details;

		-- Bulk Insert data in crm_sales_details table
		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		PRINT '-------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_CUST_AZ12'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		-- Bulk Insert data in erp_CUST_AZ12 table
		PRINT '>> Inserting Data Into: bronze.erp_CUST_AZ12'
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_LOC_A101'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.erp_LOC_A101;

		PRINT '>> Inserting Data Into: bronze.erp_LOC_A101'
		-- Bulk Insert data in erp_LOC_A101 table
		BULK INSERT bronze.erp_LOC_A101
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2'
		-- Before bulk inserting data, truncate table since we are doing full load
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		PRINT '>> Inserting Data Into: bronze.erp_PX_CAT_G1V2'
		-- Bulk Insert data in erp_PX_CAT_G1V2 table
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'D:\SHIVAM\Data Science\Data With Baraa\Data Engineer Portfolio Project- SQL\sql-data-warehouse-project (self)\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================';
		PRINT 'Bronze Layer Loading Complete.';
		PRINT 'Total Load Duration: ' + CAST (DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END
