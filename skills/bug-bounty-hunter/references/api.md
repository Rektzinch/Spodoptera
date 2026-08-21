# API assessment

Map REST, OpenAPI/Swagger, JSON-RPC, and versioned APIs before testing. Compare documented, client-referenced, and observed routes.

Inspect method handling, content types, validation, pagination, filtering, sorting, sparse fields, version differences, error detail, rate-control behavior, and trust boundaries between client, gateway, and service. Treat mass assignment and excessive data exposure as hypotheses requiring a role/object control.

For every object endpoint identify owner, other-user, and privileged controls. For every function identify anonymous, normal-user, and privileged controls. Test one synthetic object and one controlled identity at a time. Record whether the gateway, application, and downstream service enforce the same policy.

Do not use `sqlmap` or broad fuzzing by default. First establish a parameter-specific indication, narrow the request set, and preserve a safe stop condition.
