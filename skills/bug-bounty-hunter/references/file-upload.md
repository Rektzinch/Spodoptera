# File upload and processing

Map accepted MIME types, extensions, content sniffing, storage location, retrieval authorization, image/document processing, archive handling, and downstream consumers. Use harmless synthetic files and non-executable markers. Test authorization to upload, read, replace, delete, and share.

Do not upload malware, web shells, oversized archives, polyglots intended to execute, or files containing secrets. Validate whether the server enforces type/size/content policy independently of the client and whether uploaded objects are private by default.

## Pipeline model

Map each transition: client validation → upload authorization → transport/parser → type/size validation → storage key → processor/scanner → metadata database → retrieval/share/delete → downstream embedding or export. Note asynchronous states and which identity is trusted at every transition.

Build an object/action matrix for owner, another test user/tenant, and privileged role across create, read, replace, share, and delete. Use only operator-created files and identifiers.

## Hypothesis areas

- policy enforced only in the client or only on one upload path;
- storage identifier or signed-link authorization inconsistent with the parent object;
- replacement/deletion checks weaker than creation/read checks;
- processor output becoming public or crossing tenants;
- filename, metadata, or declared type trusted by a downstream renderer;
- temporary, failed, quarantined, or asynchronous objects accessible unexpectedly.

## Safe testing and evidence

Use small inert files with unique non-secret markers and valid/invalid control pairs. Do not test execution, resource exhaustion, archive expansion, parser exploitation, or malware behavior. Record request, returned object ID, storage/retrieval path, processing state, authorization context, and cleanup result.

A finding requires a crossed storage, execution, tenant, or content-policy boundary with bounded impact. MIME/extension disagreement alone is an observation. Remove synthetic objects when permitted and record anything that could not be cleaned up.
