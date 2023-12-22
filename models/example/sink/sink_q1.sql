{{ config(materialized='sink') }}
CREATE SINK IF NOT EXISTS sink_q1 from {{ ref('q1') }} 
WITH (
    connector = 'blackhole'
)