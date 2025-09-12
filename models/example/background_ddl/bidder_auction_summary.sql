{{ config(
    materialized='materialized_view',
    background_ddl=true,
    indexes=[
      {'columns': ['bidder']},
      {'columns': ['auction', 'bidder']}
    ],
    tags=['background_ddl_example']
) }}

SELECT
    bidder,
    auction,
    MAX(price) AS max_price,
    COUNT(*) AS bid_count,
    MAX(date_time) AS latest_bid_time
FROM {{ ref('q1_background_mv') }}
GROUP BY bidder, auction
