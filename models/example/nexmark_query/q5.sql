SELECT AuctionBids.auction, AuctionBids.num FROM (
    SELECT
    bid.auction,
    count(*) AS num,
    window_start AS starttime
    FROM
    HOP({{ ref('bid') }}, date_time, INTERVAL '2' SECOND, INTERVAL '10' SECOND)
    GROUP BY
    window_start,
    bid.auction
) AS AuctionBids
JOIN (
    SELECT
    max(CountBids.num) AS maxn,
    CountBids.starttime_c
    FROM (
    SELECT
    count(*) AS num,
    window_start AS starttime_c
    FROM HOP({{ ref('bid') }}, date_time, INTERVAL '2' SECOND, INTERVAL '10' SECOND)
    GROUP BY
    bid.auction,
    window_start
    ) AS CountBids
    GROUP BY
    CountBids.starttime_c
) AS MaxBids
ON AuctionBids.starttime = MaxBids.starttime_c AND AuctionBids.num >= MaxBids.maxn