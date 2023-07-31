Use dbt to manage nexmark sql in RisingWave!

### Create source in RisingWave

Run the following sql to create a nexmark source in RisingWave before using dbt.

```sql
CREATE SOURCE nexmark (
  event_type BIGINT,
  person STRUCT<"id" BIGINT,
                "name" VARCHAR,
                "email_address" VARCHAR,
                "credit_card" VARCHAR,
                "city" VARCHAR,
                "state" VARCHAR,
                "date_time" TIMESTAMP,
                "extra" VARCHAR>,
  auction STRUCT<"id" BIGINT,
                 "item_name" VARCHAR,
                 "description" VARCHAR,
                 "initial_bid" BIGINT,
                 "reserve" BIGINT,
                 "date_time" TIMESTAMP,
                 "expires" TIMESTAMP,
                 "seller" BIGINT,
                 "category" BIGINT,
                 "extra" VARCHAR>,
  bid STRUCT<"auction" BIGINT,
             "bidder" BIGINT,
             "price" BIGINT,
             "channel" VARCHAR,
             "url" VARCHAR,
             "date_time" TIMESTAMP,
             "extra" VARCHAR>,
  date_time TIMESTAMP AS
    CASE
        WHEN event_type = 0 THEN (person).date_time
        WHEN event_type = 1 THEN (auction).date_time
        ELSE (bid).date_time
    END,
  WATERMARK FOR date_time AS date_time - INTERVAL '4' SECOND
) WITH (
    connector = 'nexmark',
    nexmark.split.num = '2',
    nexmark.min.event.gap.in.ns = '10000000'
);
```

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
