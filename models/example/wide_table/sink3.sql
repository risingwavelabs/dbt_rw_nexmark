{{ config(materialized='sink', tags=['wide_table_example']) }}

CREATE SINK {{ this }} INTO {{ ref('wide_d') }} (v3, k) AS
SELECT v3, k FROM {{ ref('d3') }}
WITH (
    type = 'append-only',
    force_append_only = 'true'
)