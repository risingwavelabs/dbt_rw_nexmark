SELECT
    Q.seller,
    AVG(Q.final) OVER
    (PARTITION BY Q.seller ORDER BY Q.date_time ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
    as avg
FROM (
    SELECT ROW_NUMBER() OVER (PARTITION BY A.id, A.seller ORDER BY B.price) as rank, A.seller, B.price as final,  B.date_time
    FROM {{ ref('auction') }} AS A, {{ ref('bid') }} AS B
    WHERE A.id = B.auction and B.date_time between A.date_time and A.expires
) AS Q
WHERE Q.rank <= 1