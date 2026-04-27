{{ config(materialized='view') }}

with input_prices(price) as (
    values
        (10.0::float8),
        (12.5::float8),
        (100.0::float8)
)
select
    price,
    {{ function('price_for_xlarge') }}(price) as xlarge_price
from input_prices
