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
    MD5(CONCAT(
        COALESCE(CAST(customer_id AS STRING), 'UNKNOWN'),
        COALESCE(region, 'UNKNOWN')
    )) AS surrogate_key,
    COALESCE(CAST(customer_id AS STRING), 'UNKNOWN') AS customer_id,
    COALESCE(UPPER(TRIM(customer_name)), 'UNKNOWN') AS customer_name,
    COALESCE(region, 'UNKNOWN') AS region,
    COALESCE(tier, 'UNKNOWN') AS tier,
    COALESCE(TO_TIMESTAMP(created_at), TO_TIMESTAMP('1970-01-01 00:00:00')) AS created_at
FROM {{ source('raw', 'customers') }}