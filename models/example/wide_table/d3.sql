{{ config(materialized='table_with_connector', tags=['wide_table_example']) }}

CREATE TABLE {{ this }} (
    v3 int, 
    k int primary key
)