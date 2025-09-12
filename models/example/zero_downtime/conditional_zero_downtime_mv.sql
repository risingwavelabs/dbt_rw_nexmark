{{ config(
    materialized='materialized_view',
    zero_downtime={'enabled': var('zero_downtime', false)},
    tags=['zero_downtime_example']
) }}

SELECT
    auction,
    bidder,
    price,
    date_time,
    CASE 
        WHEN price > 1000 THEN 'high'
        WHEN price > 100 THEN 'medium'
        ELSE 'low'
    END as price_tier
FROM {{ ref('bid') }}
WHERE price > 0