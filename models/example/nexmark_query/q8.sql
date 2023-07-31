SELECT
    P.id,
    P.name,
    P.starttime
FROM (
    SELECT
    id,
    name,
    window_start AS starttime,
    window_end AS endtime
    FROM
    TUMBLE({{ ref('person') }}, date_time, INTERVAL '10' SECOND)
    GROUP BY
    id,
    name,
    window_start,
    window_end
) P
JOIN (
    SELECT
    seller,
    window_start AS starttime,
    window_end AS endtime
    FROM
    TUMBLE({{ ref('auction') }}, date_time, INTERVAL '10' SECOND)
    GROUP BY
    seller,
    window_start,
    window_end
) A ON P.id = A.seller
    AND P.starttime = A.starttime
    AND P.endtime = A.endtime