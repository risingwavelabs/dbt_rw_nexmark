select *
from {{ ref('js_udf_http_post_example') }}
where echoed_value != prefix || ':' || value
