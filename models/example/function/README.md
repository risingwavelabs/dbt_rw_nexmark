# Function Example

This directory is the live validation example for first-version `dbt-risingwave` function support.

It covers the supported paths only:

- SQL scalar function
- JavaScript scalar function through a `.sql` function file plus `config.language: javascript`
- function reference from a model
- singular tests against the produced result and catalog state

Run it with:

```bash
dbt build --select +udf_price_example +js_udf_price_example
```
