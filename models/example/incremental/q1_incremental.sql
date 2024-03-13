{{ config(
    materialized = 'incremental',
)}}
select * from {{ ref('q1') }}

{% if is_incremental() %}

  where date_time >= (select max(date_time) from {{ this }})

{% endif %}