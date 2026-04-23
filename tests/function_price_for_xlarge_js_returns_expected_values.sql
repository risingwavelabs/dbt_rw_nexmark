select *
from {{ ref('js_udf_price_example') }}
where xlarge_price != price * 2
