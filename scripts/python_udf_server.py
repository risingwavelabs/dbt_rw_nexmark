#!/usr/bin/env python3
from arrow_udf import UdfServer, udf


@udf(input_types=["FLOAT64"], result_type="FLOAT64")
def price_for_xlarge_py(price: float) -> float:
    return price * 2


def main() -> None:
    server = UdfServer(location="127.0.0.1:8815")
    server.add_function(price_for_xlarge_py)
    print("python udf server listening on 127.0.0.1:8815", flush=True)
    server.serve()


if __name__ == "__main__":
    main()
