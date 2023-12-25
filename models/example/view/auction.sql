SELECT (auction).id,
       (auction).item_name,
       (auction).description,
       (auction).initial_bid,
       (auction).reserve,
       (auction).expires,
       (auction).seller,
       (auction).category,
       (auction).extra,
       date_time
FROM {{ ref('nexmark') }}
WHERE event_type = 1