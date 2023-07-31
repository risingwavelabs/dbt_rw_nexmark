SELECT
    auction,
    bidder,
    0.908 * price as price,
    date_time
FROM {{ ref('bid') }}