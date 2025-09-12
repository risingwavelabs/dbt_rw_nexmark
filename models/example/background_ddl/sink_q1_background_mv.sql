{{ config(
    materialized='sink',
    background_ddl=true,
    tags=['background_ddl_example']
) }}

CREATE SINK IF NOT EXISTS {{ this }} FROM {{ ref('q1_background_mv') }}
WITH (
    connector = 'blackhole'
)
