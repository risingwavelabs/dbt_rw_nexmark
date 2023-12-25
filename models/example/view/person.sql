SELECT (person).id,
       (person).name,
       (person).email_address,
       (person).credit_card,
       (person).city,
       (person).state,
       (person).extra,
       date_time
FROM {{ ref('nexmark') }}
WHERE event_type = 0