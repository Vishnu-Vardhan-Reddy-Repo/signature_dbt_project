{{ config(
    materialized='view',
    database='analytics',
    schema='staging',
    alias='stg_orders',
    tags=['staging', 'orders'],
    full_refresh=true
) }}

-- Model: stg_orders
-- Purpose: Clean and standardize raw order data for downstream models

SELECT
  TRIM(ORDER_ID) AS order_id,
  TRIM(CUSTOMER_ID) AS customer_id,
  TO_TIMESTAMP(ORDER_DATE) AS order_date,
  AMOUNT AS amount
FROM {{ source('raw', 'orders') }}
