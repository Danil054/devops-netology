#!/usr/bin/env python3

import sentry_sdk
sentry_sdk.init(
    dsn="***",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)
division_by_zero = 1 / 0
print("Hello, World!")

