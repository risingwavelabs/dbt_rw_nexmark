{{ config(materialized='sink', tags=['wide_table_example']) }}

CREATE SINK {{ this }} INTO {{ ref('wide_d') }} (v2, k) AS
SELECT v2, k FROM {{ ref('d2') }}
WITH (
    type = 'append-only',
    force_append_only = 'true'
)