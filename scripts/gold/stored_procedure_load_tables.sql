/*
===================================================================================================================
This query creates a Stored Procedure that loads the tables of the gold layer
===================================================================================================================
*/
CREATE OR ALTER PROCEDURE gold.load
AS
BEGIN
  TRUNCATE TABLE gold.dim_customers 
  INSERT INTO gold.dim_customers (
  customer_id,
  customer_key,
  customer_firstname,
  customer_lastname,
  country,
  gender,
  marital_status,
  birth_date
  )
    SELECT
      silver.crm_cust_info.cst_id,
      cst_key,
      cst_firstname,
      cst_lastname,
      ISNULL(country, 'n/a'),
      COALESCE(silver.erp_cust_az12.gender, silver.crm_cust_info.cst_gndr, 'n/a') gender,
      ISNULL(cst_marital_status, 'n/a') cst_marital_status,
      ISNULL(CAST(birth_dt AS VARCHAR), 'n/a') birth_dt
    FROM silver.crm_cust_info
    LEFT JOIN silver.erp_cust_az12
    ON silver.crm_cust_info.cst_key = silver.erp_cust_az12.cst_id
    LEFT JOIN silver.erp_loc_a101
    ON silver.crm_cust_info.cst_key = REPLACE(silver.erp_loc_a101.cst_id, '-', '');

  TRUNCATE TABLE gold.dim_products
  INSERT INTO gold.dim_products (
    product_id,
    category_id,
    product_key,
    sub_category,
    product_name,
    product_cost,
    maintenance,
    product_line,
    product_start_date,
    product_end_date
    )
      SELECT
        prd_id,
        silver.crm_prd_info.cat_id,
        prd_key,
        silver.erp_px_cat_g1v2.sub_cat,
        prd_nm,
        prd_cost,
        maintenance,
        prd_line,
        prd_start_dt,
        prd_end_dt
      FROM silver.crm_prd_info
      LEFT JOIN silver.erp_px_cat_g1v2
      ON silver.crm_prd_info.cat_id = silver.erp_px_cat_g1v2.cat_id;
    TRUNCATE TABLE gold.fact_orders
    INSERT INTO gold.fact_orders (
      order_number,
      product_name,
      customer_fullname,
      order_date,
      ship_date,
      due_date,
      price,
      quantity,
      sales
    )
      SELECT 
        sls_ord_num,
        prd_nm,
        CONCAT(cst_firstname, cst_lastname) cst_fullname,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_price,
        sls_quantity,
        sls_sales
      FROM silver.crm_sales_details
      LEFT JOIN silver.crm_cust_info
      ON cst_id = sls_cust_id
      LEFT JOIN silver.crm_prd_info
      ON sls_prd_key = prd_key;
END
