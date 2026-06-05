/*
===========================================================================================================================
This SQL Query Create a Stored Procedure that loads data to the tables in bronze layer
===========================================================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load -- Creates the Stored Procedure or edits it if it exists
AS
BEGIN
	TRUNCATE TABLE bronze.crm_cust_info -- Voids all rows in the table bronze.crm_cust_info
	BULK INSERT bronze.crm_cust_info -- Insert large volume of data from the .csv file to the table bronze.crm_cust_info
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
	WITH (
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);

	TRUNCATE TABLE bronze.crm_prd_info -- Voids all rows in the table bronze.crm_prd_info
	BULK INSERT bronze.crm_prd_info -- Insert large volume of data from the .csv file to the table bronze.crm_prd_info
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
	WITH (
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);

	TRUNCATE TABLE bronze.crm_sales_details -- Voids all rows in the table bronze.crm_sales_details
	BULK INSERT bronze.crm_sales_details -- Insert large volume of data from the .csv file to the table bronze.crm_sales_details
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
	WITH (
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);

	TRUNCATE TABLE bronze.erp_cust_az12 -- Voids all rows in the table bronze.erp_cust_az12
	BULK INSERT bronze.erp_cust_az12 -- Insert large volume of data from the .csv file to the table bronze.erp_cust_az12
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
	WITH ( 
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);
	
	TRUNCATE TABLE bronze.erp_loc_a101 -- Voids all rows in the table bronze.erp_loc_a101
	BULK INSERT bronze.erp_loc_a101 -- Insert large volume of data from the .csv file to the table bronze.erp_loc_a101
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
	WITH (
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);

	TRUNCATE TABLE bronze.erp_px_cat_g1v2 -- Voids all rows in the table bronze.erp_px_cat_g1v2 
	BULK INSERT bronze.erp_px_cat_g1v2 -- Insert large volume of data from the .csv file to the table bronze.erp_px_cat_g1v2
	FROM 'C:\Users\YACINE\Desktop\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
	FIRSTROW = 2, -- Starts extracting rows from the 2nd row
	FIELDTERMINATOR = ',', -- Separates rows by commas
	TABLOCK -- Locks the table and handles the data as a single unit
	);

END
