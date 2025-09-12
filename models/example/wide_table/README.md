# Wide Table Example using Table Sinks

This is the exact example from RisingWave documentation for maintaining wide tables with table sinks using multiple sinks with the same primary key.

## Overview

Instead of using expensive JOIN operations, this approach creates multiple sinks that feed data into a single wide table. The table uses `ON CONFLICT DO UPDATE IF NOT NULL` to merge data from different sources efficiently.

## Architecture

```
d1 (v1, k) ──┐
             ├──► wide_d (v1, v2, v3, k)
d2 (v2, k) ──┤
             └──► (merged via table sinks)
d3 (v3, k) ──┘
```

## Files Structure

- `d1.sql` - Source table with v1 and primary key k
- `d2.sql` - Source table with v2 and primary key k  
- `d3.sql` - Source table with v3 and primary key k
- `wide_d.sql` - Target wide table with conflict resolution
- `sink1.sql` - Sink feeding d1 data to wide_d
- `sink2.sql` - Sink feeding d2 data to wide_d
- `sink3.sql` - Sink feeding d3 data to wide_d

## Usage

1. Deploy all tables first (source tables and wide table):
```bash
dbt run --models d1 d2 d3 wide_d
```

2. Deploy the sinks to start feeding data into the wide table:
```bash
dbt run --models sink1 sink2 sink3
```

Or deploy everything at once:
```bash
dbt run --models tag:wide_table_example
```

3. The wide table will be populated automatically by the three sinks:
   - Each sink is configured as `append-only` with `force_append_only = 'true'`
   - The wide table uses `ON CONFLICT DO UPDATE IF NOT NULL` to merge data
   - Data is combined using `k` as the primary key

## Key Features

- **Efficient Data Combination**: Avoids expensive streaming joins
- **Conflict Resolution**: Uses `ON CONFLICT DO UPDATE IF NOT NULL` for safe merging
- **Append-Only Sinks**: Prevents accidental data deletion
- **Real-time Updates**: Changes in source tables automatically propagate to the wide table

## Query the Wide Table

```sql
SELECT v1, v2, v3, k 
FROM {{ ref('wide_d') }}
WHERE v1 IS NOT NULL 
  AND v2 IS NOT NULL 
  AND v3 IS NOT NULL
```