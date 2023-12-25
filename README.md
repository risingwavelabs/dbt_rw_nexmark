Use dbt to manage nexmark queries in RisingWave!

### What is this repo

This is a self-contained playground dbt project for RisingWave and we assume you have already depolyed RisingWave successfully in your environment.

### Models structure

```
models
└── example
    ├── dbt_packages
    ├── nexmark_query (define materialized_views, which is an alternative of the incremental model in risingwave)
    ├── sink (define sinks in risingwave dbt)
    ├── source (define sources in risingwave dbt)
    ├── table(define tables with indexes in risingwave dbt)
    ├── table_with_connector (define a table with connector in risingwave dbt)
    └── view (define views in risingwave dbt)
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
