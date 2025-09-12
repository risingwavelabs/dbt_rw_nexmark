{{ config(
    materialized='materialized_view',
    zero_downtime={'enabled': true},
    tags=['zero_downtime_example']
) }}

SELECT
    auction,
    bidder,
    0.908 * price as price,
    date_time
FROM {{ ref('bid') }}