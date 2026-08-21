# WebSocket

Record handshake origin, authentication, subprotocol, message schema, authorization context, and close behavior. Test one synthetic channel/object per identity and compare subscribe, publish, read, and administrative messages.

Keep message counts low. Do not broadcast, subscribe to unrelated users, or send state-mutating messages without explicit authorization. Preserve frames with secrets redacted.
