/*
===========================================================================================================================
This SQL Query builds the tables inside the database DataWarehouse:
crm_cust_info, crm_prd_info, crm_sales_details, erp_cust_az12, erp_loc_a101, erp_px_cat_g1v2.
CAUTION: This Query forces to delete the mentioned tables so make sure you make a backup before executing.
===========================================================================================================================
*/
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL -- Checks if a table named bronze.crm_cust_info exists
BEGIN
	DROP TABLE bronze.crm_cust_info; -- Drops the table bronze.crm_cust_info
END
GO

CREATE TABLE bronze.crm_cust_info ( -- Create the table bronze.crm_cust_info
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status CHAR(1),
	cst_gndr CHAR(1),
	cst_create_date DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL -- Checks if table named bronze.crm_prd_info exists
BEGIN
	DROP TABLE bronze.crm_prd_info; -- Drops the table bronze.crm_prd_info
END
GO

CREATE TABLE bronze.crm_prd_info ( -- Create the table bronze.crm_prd_info
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line CHAR(1),
	prd_start_dt DATE,
	prd_end_dt DATE
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL -- Checks if table named bronze.crm_sales_details exists
BEGIN
	DROP TABLE bronze.crm_sales_details; -- Drops the table bronze.crm_sales_details
END
GO

CREATE TABLE bronze.crm_sales_details ( -- Create the table bronze.crm_sales_details
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL -- Checks if table named bronze.erp_cust_az12 exists
BEGIN
	DROP TABLE bronze.erp_cust_az12; -- Drops the table bronze.erp_cust_az12
END
GO

CREATE TABLE bronze.erp_cust_az12 ( -- Create the table bronze.erp_cust_az12
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL -- Checks if table named bronze.erp_loc_a101 exists
BEGIN
	DROP TABLE bronze.erp_loc_a101; -- Drops the table bronze.erp_loc_a101
END
GO

CREATE TABLE bronze.erp_loc_a101 ( -- Create the table bronze.erp_loc_a101
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL -- Checks if table named bronze.erp_px_cat_g1v2 exists
BEGIN
	DROP TABLE bronze.erp_px_cat_g1v2; -- Drops the table bronze.erp_px_cat_g1v2
END
GO

CREATE TABLE bronze.erp_px_cat_g1v2 ( -- Create the table bronze.erp_px_cat_g1v2
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
);
