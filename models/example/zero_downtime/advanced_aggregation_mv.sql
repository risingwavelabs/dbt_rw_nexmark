{{ config(
    materialized='materialized_view',
    zero_downtime={'enabled': true},
    indexes=[
        {'columns': ['auction_id']},
        {'columns': ['total_bids']}
    ],
    tags=['zero_downtime_example']
) }}

SELECT 
    a.auction_id,
    a.item_name,
    a.category,
    COUNT(b.bidder) as total_bids,
    MAX(b.price) as max_bid,
    AVG(b.price) as avg_bid,
    MIN(b.date_time) as first_bid_time,
    MAX(b.date_time) as last_bid_time
FROM {{ ref('auction_zero_downtime_view') }} a
LEFT JOIN {{ ref('bid_zero_downtime_view') }} b 
    ON a.auction_id = b.auction_id
GROUP BY 
    a.auction_id,
    a.item_name,
    a.category