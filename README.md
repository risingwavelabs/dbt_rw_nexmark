Use dbt to manage nexmark queries in RisingWave!

### What is this repo

This is a self-contained playground dbt project for RisingWave featuring comprehensive examples of:

- **Nexmark benchmark queries** as materialized views
- **Background DDL** for supported async DDL paths in dbt-risingwave
- **Zero downtime rebuilds** for production deployments  
- **Wide table patterns** with tagged examples
- **Incremental models** for streaming data processing
- **Various materializations**: tables, views, sinks, and sources
- **CI/CD integration** with automated testing

We assume you have already deployed RisingWave successfully in your environment.

### Models structure

```
models
└── example
    ├── background_ddl (background DDL examples)
    ├── function (SQL scalar, JavaScript scalar, and external Python scalar function examples)
    ├── incremental (incremental models for streaming data)
    ├── nexmark_query (materialized views for benchmark queries)
    ├── sink (sinks for data export)
    ├── source (source definitions)
    ├── table (tables with indexes)
    ├── table_with_connector (tables with external connectors)
    ├── view (standard views)
    ├── wide_table (wide table example with tags)
    └── zero_downtime (zero downtime rebuild examples)
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

### Running specific examples

Run wide table examples:
```bash
$ dbt run --select tag:wide_table_example
```

Run background DDL examples:
```bash
$ dbt run --select +tag:background_ddl_example
```

Start the local HTTP server used by the async JavaScript UDF examples:
```bash
$ python3 scripts/js_udf_http_server.py
```

The JavaScript HTTP examples use `JS_UDF_HTTP_BASE_URL`, defaulting to `http://127.0.0.1:18080`.
Set `JS_UDF_HTTP_BIND_HOST=0.0.0.0` when RisingWave runs in a separate container and must reach this mock service through the host network.

Start the local external Python UDF server used by the Python function example:
```bash
$ python3 -m pip install -r scripts/python_udf_server_requirements.txt
$ python3 scripts/python_udf_server.py
```

The external Python example uses `PY_UDF_SERVER_URL`, defaulting to `http://127.0.0.1:8815`.
Set `PY_UDF_SERVER_BIND_HOST=0.0.0.0` when RisingWave runs in a separate container and must reach this UDF server through the host network.

Run the scalar function examples and their tests:
```bash
$ dbt build --select +udf_price_example +js_udf_price_example +py_udf_price_example +js_udf_http_get_example +js_udf_http_post_example
```

The external Python example currently uses `functions/*.sql` plus:
- `config.language: python`
- `config.link: http://127.0.0.1:8815`

Run zero downtime examples:
```bash
$ dbt run --select +tag:zero_downtime_example --vars 'zero_downtime: true'
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
