
CREATE DATABASE Olist_Analytics;
USE Olist_Analytics;

CREATE TABLE Orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2,
    order_delivered_carrier_date DATETIME2,
    order_delivered_customer_date DATETIME2,
    order_estimated_delivery_date DATETIME2
);

BULK INSERT Orders
FROM 'D:\archive\olist_orders_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT * FROM Orders;

SELECT
    order_id,
    customer_id,
    LEN(order_id) AS Order_ID_Length,
    LEN(customer_id) AS Customer_ID_Length
FROM Orders;

SELECT
    order_status,
    COUNT(*) AS order_status_count
FROM Orders
GROUP BY order_status;
