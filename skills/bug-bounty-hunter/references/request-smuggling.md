# Request parsing and smuggling hypotheses

Only test request parsing when the target, proxy path, and rate/concurrency constraints explicitly allow it. Compare front-end/back-end handling of method, length, transfer encoding, duplicate headers, and connection reuse using safe, isolated requests.

Do not send desynchronizing payloads to shared production connections, poison queues, or affect other users. If the environment cannot safely isolate the test, record a hypothesis and recommend a controlled staging reproduction.
