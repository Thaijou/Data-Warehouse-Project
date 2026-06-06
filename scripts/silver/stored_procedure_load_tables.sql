/*
==============================================================================================================================
This query creates a Stored Procedure that loads the cleansed version of bronze layer tables into silver layer
==============================================================================================================================
*/
CREATE OR ALTER PROCEDURE silver.load
AS
BEGIN
	TRUNCATE TABLE silver.crm_cust_info -- Voids Rows from the table silver.crm_cust_info
	INSERT INTO silver.crm_cust_info ( -- Insert the better cleansed version of bronze.crm_cust_info by SELECT Statement
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date
	)
		SELECT 
			cst_id,
			TRIM(cst_key) cst_key,
			TRIM(cst_firstname) cst_firstname,
			TRIM(cst_lastname) cst_lastname,
			CASE cst_marital_status
				WHEN 'M' THEN 'Married'
				WHEN 'S' THEN 'Single'
				ELSE 'n/a'
			END cst_marital_status,
			CASE cst_gndr
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
			END cst_gndr,
			cst_create_date
		FROM 
			(SELECT 
				*,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) recent
			FROM bronze.crm_cust_info)t
		WHERE cst_id IS NOT NULL AND recent = 1
	;

	TRUNCATE TABLE silver.crm_prd_info
	INSERT INTO silver.crm_prd_info (
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
	)
		SELECT 
		prd_id,
		REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') cat_key,
		SUBSTRING(prd_key, 7, LEN(prd_key)) prd_key,
		prd_nm,
		prd_cost,
		CASE UPPER(prd_line)
			WHEN 'T' THEN 'Touring'
			WHEN 'M' THEN 'Mountains'
			WHEN 'S' THEN 'Other Sales'
			WHEN 'R' THEN 'Road'
			ELSE 'n/a'
		END prd_line,
		prd_start_dt,
		ISNULL(DATEADD(day, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)), GETDATE()) prd_end_dt
		FROM bronze.crm_prd_info
		WHERE prd_cost IS NOT NULL
	;

	TRUNCATE TABLE silver.crm_sales_details
	INSERT INTO silver.crm_sales_details (
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	)
		SELECT
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE 
				WHEN LEN(CAST(sls_order_dt AS VARCHAR)) != 8
				THEN DATEADD(day, -4, CAST(CONCAT(SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 1, 4),
				'-',
				SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 5, 2),
				'-',
				SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 7, 2)) AS DATE))
				ELSE CAST(CONCAT(SUBSTRING(CAST(sls_order_dt AS VARCHAR), 1, 4),
				'-',
				SUBSTRING(CAST(sls_order_dt AS VARCHAR), 5, 2),
				'-',
				SUBSTRING(CAST(sls_order_dt AS VARCHAR), 7, 2)) AS DATE)
			END sls_order_dt,
			CAST(CONCAT(SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 1, 4),
			'-',
			SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 5, 2),
			'-',
			SUBSTRING(CAST(sls_ship_dt AS VARCHAR), 7, 2)) AS DATE) sls_ship_dt,
			CAST(CONCAT(SUBSTRING(CAST(sls_due_dt AS VARCHAR), 1, 4),
			'-',
			SUBSTRING(CAST(sls_due_dt AS VARCHAR), 5, 2),
			'-',
			SUBSTRING(CAST(sls_due_dt AS VARCHAR), 7, 2)) AS DATE) sls_due_dt,
			ISNULL(sls_sales, 0) sls_sales,
			sls_quantity,
			ISNULL(sls_price, 0) sls_price
		FROM bronze.crm_sales_details
	;

	TRUNCATE TABLE silver.erp_cust_az12
	INSERT INTO silver.erp_cust_az12 (
		cst_id,
		birth_dt,
		gender
	)
		SELECT 
			*
		FROM  bronze.erp_cust_az12
	;

	TRUNCATE TABLE silver.erp_loc_a101
	INSERT INTO silver.erp_loc_a101 (
		cst_id,
		country
	)

		SELECT
			*
		FROM bronze.erp_loc_a101
	;

	TRUNCATE TABLE silver.erp_px_cat_g1v2
	INSERT INTO silver.erp_px_cat_g1v2 (
		cat_id,
		sub_cat,
		maintenance
	)

		SELECT 
			*
		FROM bronze.erp_px_cat_g1v2
END

