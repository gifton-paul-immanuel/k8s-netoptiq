FROM debian:latest

RUN apt-get update -y && apt-get install -y bison flex libevent-dev vim wget libexpat1-dev libhiredis-dev redis-server libnghttp2-dev libprotobuf-c-dev build-essential libssl-dev libsystemd-dev protobuf-c-compiler python3-dev swig python-is-python3

COPY unbound-release-1.19.0.tar.gz /

WORKDIR /

RUN tar -xvzf unbound-release-1.19.0.tar.gz

COPY redis.conf /etc/redis/redis.conf

RUN export CFLAGS="-O2"

WORKDIR /unbound-release-1.19.0

RUN ./configure --build=amd64-linux-gnu --prefix=/usr --includedir=\${prefix}/include --infodir=\${prefix}/share/info --libdir=\${prefix}/lib/aarch64-linux-gnu --mandir=\${prefix}/share/man --localstatedir=/var --runstatedir=/run --sysconfdir=/etc --with-chroot-dir= --with-dnstap-socket-path=/run/dnstap.sock --with-libevent --with-libhiredis --with-libnghttp2 --with-pidfile=/run/unbound.pid --with-pythonmodule --with-pyunbound --with-rootkey-file=/var/lib/unbound/root.key --disable-dependency-tracking --disable-flto --disable-maintainer-mode --disable-option-checking --disable-rpath --disable-silent-rules --enable-cachedb --enable-dnstap --enable-subnet --enable-systemd --enable-tfo-client --enable-tfo-server && make && make install

WORKDIR /

COPY scripts /scripts

WORKDIR /scripts/post-install

RUN ./post-install.sh

COPY unbound.conf /etc/unbound/unbound.conf

RUN touch /var/log/unbound.log && chown unbound:unbound /var/log/unbound.log && chmod 755 /var/log/unbound.log

RUN /etc/init.d/unbound start

EXPOSE 53/udp 53/tcp


