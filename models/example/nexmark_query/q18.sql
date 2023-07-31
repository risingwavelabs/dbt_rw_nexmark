SELECT auction, bidder, price, channel, url, date_time, extra
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY bidder, auction ORDER BY date_time DESC) AS rank_number
    FROM {{ ref('bid') }})
WHERE rank_number <= 1