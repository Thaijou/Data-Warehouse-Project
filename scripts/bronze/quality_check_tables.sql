/*
================================================================================================================
These are a group of queries to check the quality of data in tables.
================================================================================================================
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.crm_cust_info
---------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
	cst_id,
	COUNT(*) repetitions
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL
-- A Query Checks for duplicates and nulls in cst_id column

SELECT
	cst_key,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_key
HAVING
	TRIM(cst_key) != cst_key
	OR cst_key IS NULL
-- A query checks the quality of cst_key column (additional spaces) or nulls

SELECT
	cst_firstname,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_firstname
HAVING
	TRIM(cst_firstname) != cst_firstname
	OR cst_firstname IS NULL
-- A query checks the quality of cst_firstname column (additional spaces) or nulls

SELECT
	cst_lastname,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_lastname
HAVING
	TRIM(cst_lastname) != cst_lastname
	OR cst_lastname IS NULL
-- A query checks the quality of cst_lastname column (additional spaces) or nulls

SELECT
	cst_marital_status,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_marital_status
HAVING
	TRIM(cst_marital_status) != cst_marital_status
	OR cst_marital_status IS NULL
-- A query checks the quality of cst_marital_status column (additional spaces) or nulls

SELECT
	cst_gndr,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_gndr
HAVING
	TRIM(cst_gndr) != cst_gndr
	OR cst_gndr IS NULL
-- A query checks the quality of cst_gndr column (additional spaces) or nulls
---------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.crm_prd_info
---------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
WHERE prd_id IS NULL
GROUP BY prd_id
HAVING COUNT(*) > 1
-- A Query Checks for duplicates and nulls in prd_id column

SELECT
	prd_key
FROM bronze.crm_prd_info
WHERE TRIM(prd_key) != prd_key OR prd_key IS NULL
-- A Query Checks the quality of column prd_key (additional spaces) and nulls

SELECT 
	prd_nm
FROM bronze.crm_prd_info
WHERE TRIM(prd_nm) != prd_nm OR prd_nm IS NULL
-- A Query Checks the quality of column prd_nm (additional spaces) and nulls

SELECT 
	prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL
-- A query Checks for nulls in prd_cost column

SELECT 
	prd_line
FROM bronze.crm_prd_info
WHERE 
	TRIM(prd_line) != prd_line
	OR prd_line IS NULL
-- A Query Checks the quality of column prd_line (additional spaces) and nulls

SELECT 
	prd_start_dt,
	prd_end_dt
FROM bronze.crm_prd_info
WHERE 
	prd_end_dt < prd_start_dt
	OR prd_end_dt IS NULL
	OR prd_start_dt IS NULL
-- A query Checks the quality of columns prd_start_dt and prd_end_dt (logical dates) and nulls
------------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.crm_sales_details
------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	sls_ord_num,
	sls_prd_key,
	COUNT(*) repetitions
FROM bronze.crm_sales_details
GROUP BY sls_ord_num, sls_prd_key
HAVING 
	sls_ord_num IS NULL
	OR sls_prd_key IS NULL
	OR TRIM(sls_ord_num) != sls_ord_num
	ORDER BY sls_ord_num
-- A Query Checks the quality of sls_ord_num and sls_prd_key columns (additional spaces) and duplicates and spaces

SELECT 
	sls_cust_id
FROM bronze.crm_sales_details
WHERE sls_cust_id IS NULL
-- A Query Checks for nulls in sls_cust_id column

SELECT 
	sls_order_dt
FROM bronze.crm_sales_details
WHERE 
	sls_order_dt IS NULL
	OR LEN(CAST(sls_order_dt AS VARCHAR)) != 8
-- A Query Checks for nulls in sls_order_dt column and its 8 digits (converable to date)

SELECT 
	sls_ship_dt
FROM bronze.crm_sales_details
WHERE 
	sls_ship_dt IS NULL
	OR LEN(CAST(sls_ship_dt AS VARCHAR)) != 8
-- A Query Checks for nulls in sls_ship_dt column and its 8 digits (converable to date)

SELECT 
	sls_due_dt
FROM bronze.crm_sales_details
WHERE 
	sls_due_dt IS NULL
	OR LEN(CAST(sls_due_dt AS VARCHAR)) != 8
-- A Query Checks for nulls in sls_due_dt column and its 8 digits (converable to date)

SELECT 
	sls_sales
FROM bronze.crm_sales_details
WHERE sls_sales IS NULL

SELECT 
	sls_quantity
FROM bronze.crm_sales_details
WHERE sls_quantity IS NULL

SELECT 
	sls_price
FROM bronze.crm_sales_details
WHERE sls_price IS NULL
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.erp_cust_az12
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	CID,
	COUNT(*) repetitions
FROM bronze.erp_cust_az12
GROUP BY CID
HAVING
	COUNT(*) > 1
	OR CID IS NULL
-- A query checks for duplicates and nulls in column CID

SELECT
	BDATE
FROM bronze.erp_cust_az12
WHERE BDATE IS NULL
-- A query checks for nulls in BDATE column

SELECT 
	GEN
FROM bronze.erp_cust_az12
WHERE GEN IS NULL
-- A Query Checks for nulls in GEN column
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.erp_loc_a101
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	CID,
	COUNT(*) repetitions
FROM bronze.erp_loc_a101
GROUP BY CID
HAVING 
	COUNT(*) > 1 
	OR CID IS NULL
-- A query checks for duplicates and nulls in column CID

SELECT 
	CNTRY
FROM silver.erp_loc_a101
WHERE CNTRY IS NULL
-- A query checks for nulls in CNTRY column
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
															-- bronze.erp_px_cat_g1v2
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	CAT,
	COUNT(*) repetitions
FROM bronze.erp_px_cat_g1v2
GROUP BY CAT
HAVING
	COUNT(*) > 1
	OR CAT IS NULL

SELECT 
	SUBCAT
FROM bronze.erp_px_cat_g1v2
WHERE SUBCAT IS NULL
-- A query check for Nulls in SUBCAT column

SELECT 
	MAINTENANCE
FROM bronze.erp_px_cat_g1v2
WHERE 
	MAINTENANCE IS NULL
	OR (
        MAINTENANCE NOT LIKE '%,YES'
        AND MAINTENANCE NOT LIKE '%,NO'
    )
-- A query checks for the quality of MAINTENANCE and nulls
