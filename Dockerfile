# syntax=docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/httpd" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/httpd/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/httpd" \
      com.jitesoft.app.httpd.version="${VERSION}"

ARG TARGETARCH
ENV PATH="/usr/local/apache2/bin:${PATH}"
ARG WWWDATA_GUID="82"
ENV WWWDATA_GUID="${WWWDATA_GUID}"

COPY entrypoint /usr/local/bin/entrypoint
COPY healthcheck /usr/local/bin/healthcheck
RUN --mount=type=bind,source=./out,target=/tmp/httpd-bin \
    adduser -u ${WWWDATA_GUID} -D -S -G www-data www-data \
 && mkdir -p /usr/local/apache2 \
 && tar -xzhf /tmp/httpd-bin/httpd-${TARGETARCH}.tar.gz -C /usr/local/apache2 \
 && touch /usr/local/apache2/logs/access_log \
 && touch /usr/local/apache2/logs/error_log \
 && RUNTIME_DEPENDENCIES="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
  && apk add --no-cache --virtual .runtime-deps libcap apr-dev apr-util-dev apr-util-ldap perl ${RUNTIME_DEPENDENCIES} \
  && chown -R www-data:www-data /usr/local/apache2 \
  && chmod +x /usr/local/bin/entrypoint \
  && chmod +x /usr/local/bin/healthcheck \
  && ln -sf /proc/self/fd/1 /usr/local/apache2/logs/access_log \
  && ln -sf /proc/self/fd/2 /usr/local/apache2/logs/error_log

WORKDIR /usr/local/apache2/htdocs
STOPSIGNAL SIGWINCH
HEALTHCHECK --interval=30s --timeout=5s CMD healthcheck
EXPOSE 80
ENTRYPOINT [ "entrypoint" ]
