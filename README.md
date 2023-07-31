Use dbt to manage nexmark queries in RisingWave!

### What is this repo

This is a self-contained playground dbt project for RisingWave and we assume you have already depolyed RisingWave successfully in your environment.

### Create source in RisingWave

To get started, you need to use `psql` to connect to your RisingWave instance and run the following sql to create a nexmark source in RisingWave before using dbt. `Source` is a fundamental concept in RisingWave to represent the source of the data. Here we view `Source` as your raw data.

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

### Run dbt

1. Install dbt-risingwave adapter https://github.com/risingwavelabs/dbt-risingwave

2. Clone this repo.

3. Change into the `dbt_rw_nexmark` directory.

```bash
$ cd dbt_rw_nexmark
```

4. Set up a profile called `dbt_rw_nexmark` to connect to RisingWave by following [dbt instructions](https://docs.getdbt.com/docs/core/connect-data-platform/connection-profiles)

The profile should look like this.
```
dbt_rw_nexmark:
  outputs:
    dev:
      dbname: dev
      host: localhost
      password: '123456'
      port: 4566
      schema: public
      threads: 1
      type: risingwave
      user: root
  target: dev
```

5. Ensure your profile is setup correctly 

```bash
$ dbt debug
```

6. Run the models:

```bash
$ dbt run
```

7. Test the output of the models:

```bash
$ dbt test
```

8. Generate documentation for the project:

```bash
$ dbt docs generate
```

9. View the documentation for the project:

```bash
$ dbt docs serve
```


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
