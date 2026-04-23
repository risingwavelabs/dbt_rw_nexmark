{{ config(materialized='view') }}

with todo_ids(id) as (
    values
        (1),
        (2),
        (3)
)
select
    id,
    {{ function('http_get_todo_name_js') }}(id) as todo_name
from todo_ids
