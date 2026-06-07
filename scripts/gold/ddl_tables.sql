/*
=================================================================================================
This query creates tables for the gold layer.
=================================================================================================
*/
IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
BEGIN
  DROP TABLE gold.dim_customers;
END
GO

CREATE TABLE gold.dim_customers (
  customer_id INT,
  customer_key NVARCHAR(50),
  customer_firstname NVARCHAR(50),
  customer_lastname NVARCHAR(50),
  country NVARCHAR(50)
  marital_status NVARCHAR(50),
  gender NVARCHAR(50),
  birth_date DATE
);

GO

IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
BEGIN
  DROP TABLE gold.dim_products;
END
GO

CREATE TABLE gold.dim_products (
  product_id INT,
	category_id NVARCHAR(50),
	product_key NVARCHAR(50),
  sub_category NVARCHAR(50),
	product_name NVARCHAR(50),
	product_cost INT,
  maintenance NVARCHAR(50),
	product_line NVARCHAR(50),
	product_start_date DATE,
	product_end_date DATE,
  
);
GO

IF OBJECT_ID('gold.fact_orders', 'U')
BEGIN
  DROP TABLE gold.fact_orders;
GO

CREATE TABLE gold.fact_orders (
  order_number NVARCHAR(50),
	product_name NVARCHAR(50),
	customer_fullname INT,
	order_date DATE,
	ship_date DATE,
	due_date DATE,
	sales INT,
	quantity INT,
	price INT,
  total_amount INT
);
