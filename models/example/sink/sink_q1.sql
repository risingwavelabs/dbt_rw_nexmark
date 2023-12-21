{{ config(materialized='sink') }}
CREATE SINK sink_q1 from {{ ref('q1') }} 
WITH (
    connector = 'blackhole'
)