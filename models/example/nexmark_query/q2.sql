SELECT auction, price FROM {{ ref('bid') }} WHERE auction = 1007 OR auction = 1020 OR auction = 2001 OR auction = 2019 OR auction = 2087