SELECT * EXCEPT (rank_number) FROM
(SELECT *, ROW_NUMBER() OVER (PARTITION BY auction ORDER BY price DESC) AS rank_number FROM {{ ref('bid') }})
WHERE rank_number <= 10