{{ config(
    materialized='materialized_view',
    zero_downtime={'enabled': true},
    tags=['zero_downtime_example']
) }}

SELECT 
    (auction).id as auction_id,
    (auction).item_name,
    (auction).description,
    (auction).initial_bid,
    (auction).reserve,
    (auction).expires,
    (auction).seller,
    (auction).category,
    (auction).extra,
    date_time
FROM {{ ref('nexmark') }}
WHERE event_type = 1