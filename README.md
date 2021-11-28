# Apache Httpd

Apache httpd running on Alpine linux.

## Notes and information

### Usage

Default docroot is set to `/usr/local/apache2/htdocs`.  

To start container, expose the port (default is `80`) in the run command and go nuts:

```bash
docker run -p 80:80 jitesoft/httpd
```

### www-data user

The www-data user have the same id as the www-data user in the most common alpine images, 82.  
Before 2021 07 23, the id was 1000, which created issues with read/write permissions
when used with the jitesoft/php image.

Containers created runs as root (easily changed in production with the appropriate flags),
while the nginx process runs as the www-data user (82) by default.

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

## Licenses

Files in this repository are released under the MIT license.  
Httpd is released under the [Apache License 2.0](https://www.apache.org/licenses/) license.  

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

### Sponsors

Jitesoft images are built via GitLab CI on runners hosted by the following wonderful organisations:

<a href="https://fosshost.org/">
  <img src="https://raw.githubusercontent.com/jitesoft/misc/master/sponsors/fosshost.png" height="128" alt="Fosshost logo" />
</a>
<a href="https://www.aarch64.com/">
  <img src="https://raw.githubusercontent.com/jitesoft/misc/master/sponsors/aarch64.png" height="128" alt="Aarch64 logo" />
</a>

_The companies above are not affiliated with Jitesoft or any Jitesoft Projects directly._

---

Sponsoring is vital for the further development and maintaining of open source.  
Questions and sponsoring queries can be made by <a href="mailto:sponsor@jitesoft.com">email</a>.  
If you wish to sponsor our projects, reach out to the email above or visit any of the following sites:

[Open Collective](https://opencollective.com/jitesoft-open-source)  
[GitHub Sponsors](https://github.com/sponsors/jitesoft)  
[Patreon](https://www.patreon.com/jitesoft)
