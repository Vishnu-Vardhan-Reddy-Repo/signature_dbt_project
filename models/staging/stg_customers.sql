{{ config(
    materialized='view',
    schema='staging',
    database='analytics',
    tags=['staging', 'customers'],
    alias='stg_customers',
    full_refresh=true,
    enabled=true
) }}

-- Model: stg_customers
-- Purpose: Standardizes raw customer data for downstream use

SELECT
  CAST(customer_id AS STRING) AS customer_id,
  UPPER(TRIM(customer_name)) AS customer_name,
  region,
  tier,
  TO_TIMESTAMP(created_at) AS created_at
FROM {{ source('raw', 'customers') }}
