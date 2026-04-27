select *
from {{ ref('js_udf_http_get_example') }}
where (id = 1 and todo_name != 'buy_milk')
   or (id = 2 and todo_name != 'ship_code')
   or (id = 3 and todo_name != 'review_pr')
