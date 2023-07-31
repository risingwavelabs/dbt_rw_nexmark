SELECT
auction, bidder, price, channel,
SPLIT_PART(url, '/', 4) as dir1,
SPLIT_PART(url, '/', 5) as dir2,
SPLIT_PART(url, '/', 6) as dir3 FROM {{ ref('bid') }} 