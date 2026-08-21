# WebSocket

Record handshake origin, authentication, subprotocol, message schema, authorization context, and close behavior. Test one synthetic channel/object per identity and compare subscribe, publish, read, and administrative messages.

Keep message counts low. Do not broadcast, subscribe to unrelated users, or send state-mutating messages without explicit authorization. Preserve frames with secrets redacted.

## Map both layers

Separate HTTP upgrade controls from message-layer controls. Record URL, origin policy, cookies/tokens, subprotocol, session binding, reconnect behavior, token refresh/expiry, and whether authorization is evaluated at connection, subscription, and each message.

Build a matrix using operator-controlled objects:

`identity | connect | subscribe own | subscribe other test user | publish | mutate | after revoke`

Discover message schemas from observed client traffic or documented protocols; do not fuzz arbitrary opcodes. Compare one identity/object/action variable at a time and record server acknowledgement, delivered frames, side effects, and close/error semantics.

Prioritize stale authorization after role/token changes, tenant/channel identifier trust, subscription versus publication asymmetry, reconnect state, and differences between equivalent HTTP and WebSocket operations.

A confirmed finding requires unauthorized read or action across a defined boundary. A successful handshake, verbose error, or guessed channel name alone is not sufficient. Stop before broadcast, high message volume, unrelated subscriptions, or production state changes.
