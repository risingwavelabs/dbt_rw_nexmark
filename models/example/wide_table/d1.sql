{{ config(materialized='table_with_connector', tags=['wide_table_example']) }}

CREATE TABLE {{ this }} (
    v1 int, 
    k int primary key
)