with built_model as (
    select *
    from {{ ref('py_udf_price_example') }}
    limit 1
)
select 1
from built_model
where not exists (
    select 1
    from rw_catalog.rw_functions
    where name = 'price_for_xlarge_py'
)
