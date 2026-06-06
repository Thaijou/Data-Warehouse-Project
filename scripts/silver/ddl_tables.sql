/*
===========================================================================================================================
This SQL Query builds these tables inside the database DataWarehouse:
crm_cust_info, crm_prd_info, crm_sales_details, erp_cust_az12, erp_loc_a101, erp_px_cat_g1v2.
CAUTION: This Query forces to delete the mentioned tables so make sure you make a backup before executing.
===========================================================================================================================
*/
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL -- Checks if a table named silver.crm_cust_info exists
BEGIN
	DROP TABLE silver.crm_cust_info; -- Drops the table silver.crm_cust_info
END
GO

CREATE TABLE silver.crm_cust_info ( -- Create the table silver.crm_cust_info
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);
GO

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL -- Checks if table named silver.crm_prd_info exists
BEGIN
	DROP TABLE silver.crm_prd_info; -- Drops the table silver.crm_prd_info
END
GO

CREATE TABLE silver.crm_prd_info ( -- Create the table silver.crm_prd_info
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
);
GO

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL -- Checks if table named silver.crm_sales_details exists
BEGIN
	DROP TABLE silver.crm_sales_details; -- Drops the table silver.crm_sales_details
END
GO

CREATE TABLE silver.crm_sales_details ( -- Create the table silver.crm_sales_details
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales DATE,
	sls_quantity INT,
	sls_price INT
);
GO

IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL -- Checks if table named silver.erp_cust_az12 exists
BEGIN
	DROP TABLE silver.erp_cust_az12; -- Drops the table silver.erp_cust_az12
END
GO

CREATE TABLE silver.erp_cust_az12 ( -- Create the table silver.erp_cust_az12
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(50)
);
GO

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL -- Checks if table named silver.erp_loc_a101 exists
BEGIN
	DROP TABLE silver.erp_loc_a101; -- Drops the table silver.erp_loc_a101
END
GO

CREATE TABLE silver.erp_loc_a101 ( -- Create the table silver.erp_loc_a101
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
);
GO

IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL -- Checks if table named silver.erp_px_cat_g1v2 exists
BEGIN
	DROP TABLE silver.erp_px_cat_g1v2; -- Drops the table silver.erp_px_cat_g1v2
END
GO

CREATE TABLE silver.erp_px_cat_g1v2 ( -- Create the table silver.erp_px_cat_g1v2
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
);
