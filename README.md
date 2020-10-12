# Apache Httpd

Apache httpd running on Alpine linux.

## Notes and information

### Usage

Default docroot is set to `/usr/local/apache2/htdocs`.  

To start container, expose the port (default is `80`) in the run command and go nuts:

```bash
docker run -p 80:80 jitesoft/httpd
```

### Cap and port 80.

The container will use a none-root user (`www-data (82)`) to run the httpd executable.  
To do this, the `net_bind_service` cap have been set for the httpd executable,
this might create some issues for some docker filesystems. If it does, change
the port of the vhost to a port above 1024 (like `8080`) and bind to that port instead
of port `80`.

### Sigwinch

The stopsignal is set to SIGWINCH to enable graceful shutdown, this will make a
`ctrl+c` exit of an attached container not exit but stay running. If you encounter this
issue, a standard `docker stop <containername>` will stop the container for you.

## Tags

Image is built for x86_64 and aarch64, tags are based on Apache httpd version
where `latest` is the latest version as of build time.

Images can be found at:

* [Docker Hub](https://hub.docker.com/r/jitesoft/httpd): `jitesoft/httpd`
* [GitLab](https://gitlab.com/jitesoft/dockerfiles/httpd): `registry.gitlab.com/jitesoft/dockerfiles/httpd`
* [GitHub](https://github.com/orgs/jitesoft/packages/container/package/httpd) `ghcr.io/jitesoft/httpd`

## Docker files

Docker files can be found at  [GitLab](https://gitlab.com/jitesoft/dockerfiles/httpd) or [GitHub](https://github.com/jitesoft/docker-httpd)

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

## Licenses

Files in this repository are released under the MIT license.  
Httpd is released under the [Apache License 2.0](https://www.apache.org/licenses/) license.  
