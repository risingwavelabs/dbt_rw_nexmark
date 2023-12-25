{{ config(materialized='sink') }}
CREATE SINK IF NOT EXISTS  {{ this }} from {{ ref('q1') }} 
WITH (
    connector = 'blackhole'
)