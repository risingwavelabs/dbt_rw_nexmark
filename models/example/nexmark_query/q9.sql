SELECT
    id, item_name, description, initial_bid, reserve, date_time, expires, seller, category,
    auction, bidder, price, bid_date_time
FROM (
    SELECT A.*, B.auction, B.bidder, B.price, B.date_time AS bid_date_time,
    ROW_NUMBER() OVER (PARTITION BY A.id ORDER BY B.price DESC, B.date_time ASC) AS rownum
    FROM {{ ref('auction') }} A, {{ ref('bid') }} B
    WHERE A.id = B.auction AND B.date_time BETWEEN A.date_time AND A.expires
)
WHERE rownum <= 1