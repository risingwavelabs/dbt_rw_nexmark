SELECT
    auction,
    to_char(date_time, 'YYYY-MM-DD') AS day,
    count(*) AS total_bids,
    count(*) filter (where price < 10000) AS rank1_bids,
    count(*) filter (where price >= 10000 and price < 1000000) AS rank2_bids,
    count(*) filter (where price >= 1000000) AS rank3_bids,
    min(price) AS min_price,
    max(price) AS max_price,
    avg(price) AS avg_price,
    sum(price) AS sum_price
FROM {{ ref('bid') }}
GROUP BY auction, to_char(date_time, 'YYYY-MM-DD')