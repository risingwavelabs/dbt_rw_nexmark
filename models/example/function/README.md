# Function Example

This directory is the live validation example for first-version `dbt-risingwave` function support.

It covers the supported paths only:

- SQL scalar function
- JavaScript scalar function through a `.sql` function file plus `config.language: javascript`
- Python scalar function through a `.sql` function file plus `config.language: python`
  - with external `config.link`
- JavaScript async HTTP GET through `fetch`
- JavaScript async HTTP POST through `fetch`
- function reference from a model
- singular tests against the produced result and catalog state

Start the local mock HTTP server and the external Python UDF server first:

```bash
python3 scripts/js_udf_http_server.py
python3 -m pip install -r scripts/python_udf_server_requirements.txt
python3 scripts/python_udf_server.py
```

The HTTP and external Python endpoints can be overridden for CI or containerized RisingWave deployments:

```bash
export JS_UDF_HTTP_BASE_URL=http://host.docker.internal:18080
export PY_UDF_SERVER_URL=http://host.docker.internal:8815
```

Run it with:

```bash
dbt build --select +udf_price_example +js_udf_price_example +py_udf_price_example +js_udf_http_get_example +js_udf_http_post_example
```
