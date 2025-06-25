{{ config(
    materialized='view',
    database='analytics',
    schema='intermediate',
    alias='int_customer_orders',
    tags=['intermediate', 'orders']
) }}

-- Model: int_customer_orders
-- Purpose: Joins orders with customer details for downstream consumption

SELECT
  o.order_id,
  o.customer_id,
  c.customer_name,
  c.region,
  c.tier,
  o.order_date,
  o.amount
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_customers') }} c
  ON o.customer_id = c.customer_id
