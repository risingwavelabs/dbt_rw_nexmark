SELECT
    auction, bidder, price, channel, url, B.date_time as date_timeB,
    item_name, description, initial_bid, reserve, A.date_time as date_timeA, expires, seller, category
FROM
    {{ ref('bid') }} B INNER JOIN {{ ref('auction') }}  A on B.auction = A.id
WHERE A.category = 10