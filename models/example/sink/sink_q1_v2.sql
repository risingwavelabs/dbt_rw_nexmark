{{
    config(
        materialized="sink",
        connector="blackhole",
        connector_parameters= {}
    )
}}
select * from {{ ref('q1') }} 
