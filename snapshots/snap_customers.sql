{% snapshot snap_customers %}
{{
    config(
        target_schema='snapshots',
        target_database='analytics',
        unique_key='customer_id',
        strategy='check',
        check_cols=['customer_name', 'region', 'tier']
    )
}}

SELECT
  customer_id,
  customer_name,
  region,
  tier,
  created_at
FROM {{ ref('stg_customers') }}

{% endsnapshot %}
