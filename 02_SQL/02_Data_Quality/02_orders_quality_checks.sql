
USE Olist_Analytics;

-- 1. Check NULL values in all columns

SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Status,
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Purchase_Timestamp,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Approved_At,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Delivered_Carrier_Date,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Delivered_Customer_Date,
    SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Estimated_Delivery_Date
FROM Orders;


-- 2. Check duplicate order IDs

SELECT
    order_id,
    COUNT(*) AS order_id_count
FROM Orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 3. Check delivery dates earlier than purchase dates

SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM Orders
WHERE order_delivered_customer_date < order_purchase_timestamp;


-- 4. Check approval dates earlier than purchase dates

SELECT
    order_id,
    order_purchase_timestamp,
    order_approved_at
FROM Orders
WHERE order_approved_at < order_purchase_timestamp;


-- 5. Investigate missing approval timestamps by order status

SELECT
    order_status,
    COUNT(*) AS order_count
FROM Orders
WHERE order_approved_at IS NULL
GROUP BY order_status
ORDER BY order_count DESC;

-- 6.How many orders have missing delivery dates?
SELECT 
    COUNT(order_id) AS Missing_Delivery_Dates
FROM Orders
WHERE order_delivered_customer_date IS NULL;

--7.How many orders are missing carrier delivery dates?
