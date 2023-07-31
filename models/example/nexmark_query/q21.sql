SELECT
auction, bidder, price, channel,
CASE
    WHEN lower(channel) = 'apple' THEN '0'
    WHEN lower(channel) = 'google' THEN '1'
    WHEN lower(channel) = 'facebook' THEN '2'
    WHEN lower(channel) = 'baidu' THEN '3'
    ELSE REGEXP_MATCH(url, '(&|^)channel_id=([^&]*)')[2]
    END
AS channel_id FROM {{ ref('bid') }}
where REGEXP_MATCH(url, '(&|^)channel_id=([^&]*)')[2] is not null or
        lower(channel) in ('apple', 'google', 'facebook', 'baidu')