# Background DDL Examples

This directory shows how to use the `background_ddl` feature from `dbt-risingwave`.

## What the examples cover

- `q1_background_mv.sql`: materialized view with `background_ddl=true`
- `bidder_auction_summary.sql`: table with `background_ddl=true` and indexes
- `sink_q1_background_mv.sql`: sink with `background_ddl=true`

These are the DDL paths currently supported by the adapter. When `background_ddl` is enabled, the adapter sets the RisingWave session variable before the DDL runs and then issues `WAIT` so dbt still waits for the object to finish building.

## Run the examples

```bash
dbt run --select +tag:background_ddl_example
```

## Per-model configuration

```sql
{{ config(materialized='materialized_view', background_ddl=true) }}
```

## Project-level configuration

You can also enable the same behavior for a folder in `dbt_project.yml`:

```yaml
models:
  dbt_rw_nexmark:
    example:
      background_ddl:
        +background_ddl: true
```

## Caveat

RisingWave `WAIT` waits for all active background creating jobs in the cluster, not only the job started by the current model. If other background DDL is running, the dbt node can take longer to complete.
