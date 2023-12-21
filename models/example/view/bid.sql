SELECT (bid).auction,
       (bid).bidder,
       (bid).price,
       (bid).channel,
       (bid).url,
       (bid).extra,
       date_time
FROM {{ ref('nexmark') }}
WHERE event_type = 2