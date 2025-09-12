{{ config(
    materialized='materialized_view',
    background_ddl=true,
    tags=['background_ddl_example']
) }}

SELECT
    auction,
    bidder,
    0.908 * price AS price,
    date_time
FROM {{ ref('bid') }}
