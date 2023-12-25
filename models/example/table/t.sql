{{ config(
    materialized = 'table',
    indexes=[
      {'columns': ['c1']},
      {'columns': ['c2', 'c1']},
    ]
)}}
select 1 as c1, 1 c2 union select 2 as c1, 2 as c2