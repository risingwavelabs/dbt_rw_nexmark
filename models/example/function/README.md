# Function Example

This directory is the live validation example for first-version `dbt-risingwave` function support.

It covers the supported paths only:

- SQL scalar function
- JavaScript scalar function through a `.sql` function file plus `config.language: javascript`
- Python scalar function through a `.sql` function file plus `config.language: python`
  - with `config.runtime_version: embedded`
- JavaScript async HTTP GET through `fetch`
- JavaScript async HTTP POST through `fetch`
- function reference from a model
- singular tests against the produced result and catalog state

Start the local mock HTTP server first:

```bash
python3 scripts/js_udf_http_server.py
```

Run it with:

```bash
dbt build --select +udf_price_example +js_udf_price_example +py_udf_price_example +js_udf_http_get_example +js_udf_http_post_example
```
