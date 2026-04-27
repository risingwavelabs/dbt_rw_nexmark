select *
from {{ ref('udf_price_example') }}
where xlarge_price != price * 2
