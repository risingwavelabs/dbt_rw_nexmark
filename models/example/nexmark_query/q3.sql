SELECT
    P.name, P.city, P.state, A.id
FROM
    {{ ref('auction') }}  AS A INNER JOIN {{ ref('person') }}  AS P on A.seller = P.id
WHERE
    A.category = 10 and (P.state = 'or' OR P.state = 'id' OR P.state = 'ca')