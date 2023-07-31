SELECT
    Q.category,
    AVG(Q.final) as avg
FROM (
    SELECT MAX(B.price) AS final, A.category
    FROM {{ ref('auction') }} A, {{ ref('bid') }} B
    WHERE A.id = B.auction AND B.date_time BETWEEN A.date_time AND A.expires
    GROUP BY A.id, A.category
) Q
GROUP BY Q.category