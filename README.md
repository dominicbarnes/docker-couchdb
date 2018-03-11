# docker-couchdb

> This docker image is a wrapper around [couchdb][base-image] (v1.x) that adds
> the ability to [bootstrap][couchdb-bootstrap] a server on startup.

## Usage

In general, you'll use this as a base image and copy your own configuration into
the `/docker-entrypoint-init.d/` volume.

Refer to [couchdb-bootstrap][couchdb-bootstrap]'s documentation for examples and
usage information. (all of that is applicable here)

```dockerfile
FROM dominicbarnes/couchdb
COPY _couchdb /docker-entrypoint-init.d
```

In addition, everything from [couchdb:1][base-image]'s documentation is
relevant too. You can include your own `local.ini` to set your start-up
configuration.


[base-image]: https://hub.docker.com/_/couchdb/
[couchdb-bootstrap]: https://github.com/jo/couchdb-bootstrap
