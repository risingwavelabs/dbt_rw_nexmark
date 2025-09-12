{{ config(
    materialized='view',
    zero_downtime={'enabled': true},
    tags=['zero_downtime_example']
) }}

SELECT 
    (bid).auction as auction_id,
    (bid).bidder,
    (bid).price,
    (bid).channel,
    (bid).url,
    (bid).extra,
    date_time
FROM {{ ref('nexmark') }}
WHERE event_type = 2