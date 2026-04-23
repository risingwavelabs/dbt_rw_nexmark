{{ config(materialized='view') }}

with payloads(prefix, value) as (
    values
        ('todo', 'buy_milk'),
        ('todo', 'ship_code')
)
select
    prefix,
    value,
    {{ function('http_post_echo_js') }}(prefix, value) as echoed_value
from payloads
