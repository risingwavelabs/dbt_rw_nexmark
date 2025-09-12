{{ config(materialized='sink', tags=['wide_table_example']) }}

CREATE SINK {{ this }} INTO {{ ref('wide_d') }} (v1, k) AS
SELECT v1, k FROM {{ ref('d1') }}
WITH (
    type = 'append-only',
    force_append_only = 'true'
)