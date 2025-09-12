# Zero Downtime Rebuilds Examples

This directory contains examples of zero downtime rebuilds for materialized views and views using RisingWave's dbt adapter.

## Prerequisites

- RisingWave v2.2+ for materialized views
- dbt-risingwave adapter with zero downtime support
- Proper database permissions for SWAP operations

## Usage

### Basic Usage

Run only zero downtime example models:
```bash
dbt run --select +tag:zero_downtime_example --vars 'zero_downtime: true'
```

Cleanup temporary relations:
```bash
dbt run-operation cleanup_temp_objects
```

## Examples

### 1. Basic Materialized View (`q1_zero_downtime_mv.sql`)
- Simple materialized view with zero downtime enabled
- Basic configuration for testing

### 2. Enhanced Materialized View (`auction_zero_downtime_mv.sql`)
- More complex query with zero downtime enabled
- Demonstrates structured data extraction

### 3. Basic View (`auction_zero_downtime_view.sql`)
- Standard view with zero downtime rebuilds
- Suitable for frequently changing view definitions

### 4. Bid Data View (`bid_zero_downtime_view.sql`)
- View for bid data with zero downtime rebuilds
- Clean extraction of bidding information

### 5. Advanced Aggregation MV (`advanced_aggregation_mv.sql`)
- Complex materialized view with aggregations
- Includes custom indexes for performance
- Demonstrates dependency handling between zero downtime objects

### 6. Conditional Zero Downtime (`conditional_zero_downtime_mv.sql`)
- Uses variables to conditionally enable zero downtime
- Flexible configuration for different environments

## Configuration Options

```sql
{{ config(
    materialized='materialized_view',  -- or 'view'
    zero_downtime={'enabled': true},   -- Enable zero downtime rebuilds
    indexes=[                          -- Optional: Add indexes to MV
        {'columns': ['column_name'], 'type': 'btree'}
    ],
    tags=['zero_downtime_example']     -- Tag for easy selection
) }}
```

## Performance Considerations

1. **Storage**: Zero downtime rebuilds require additional temporary storage
2. **Memory**: SWAP operations may cause brief memory spikes
3. **Timing**: Run during low-traffic periods when possible

## Best Practices

1. **Test First**: Always test zero downtime rebuilds in development
2. **Monitor Resources**: Watch storage and memory usage during rebuilds
3. **Plan Dependencies**: Consider downstream objects when planning rebuilds
4. **Validate Results**: Verify data integrity after SWAP operations

## Troubleshooting

- If SWAP fails, temporary objects remain for investigation
- Check RisingWave logs for detailed error messages
- Verify sufficient storage space before rebuilding large MVs
- Ensure no schema conflicts between original and temporary objects