# FROM ruby:2.6.0-alpine

# # # Install packages
# RUN apk update && apk upgrade

# # Rails prereqs
# RUN apk add --update --no-cache postgresql-dev nodejs tzdata

# # RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
# # RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk
# # RUN apk add glibc-2.30-r0.apk
# # # Add /lib/ld-linux-x86-64.so.2 for AppDynamics
# # # RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

# RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
# RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk
# RUN apk add glibc-2.30-r0.apk

# # # install glibc
# # RUN apk add --update --no-cache tar zstd
# # RUN wget http://www.archlinux.org/packages/community/x86_64/busybox/download/ -O busybox.pkg.tar.zst
# # RUN wget http://www.archlinux.org/packages/core/x86_64/glibc/download/ -O glibc.pkg.tar.zst
# # RUN mkdir -p ~/chroot/bin/ ~/chroot/dev ~/chroot/proc ~/chroot/root ~/chroot/etc
# # RUN for i in *.pkg.tar.zst; do tar -I zstd -xvf $i -C ~/chroot; done
# # RUN cp /etc/resolv.conf ~/chroot/etc/
# # RUN ln -s /bin/busybox ~/chroot/bin/sh
# # RUN ln -s /bin/busybox ~/chroot/bin/ln
# # # RUN for i in $(busybox --list);do ln -s /bin/busybox /usr/bin/$i;done
# # RUN chroot ~/chroot /bin/sh

# RUN apk add --no-cache --virtual .build-deps \
#   build-base git

FROM ruby:2.6.0

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get install apt-transport-https nodejs yarn -yqq


# Install Deco
ARG DECO_VERSION=0.3.1
ARG DECO_OS=linux
ARG DECO_ARCH=amd64
ADD https://github.com/YaleUniversity/deco/releases/download/v${DECO_VERSION}/deco-v${DECO_VERSION}-${DECO_OS}-${DECO_ARCH} /usr/local/bin/deco
RUN chmod 555 /usr/local/bin/deco && deco version

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

# RUN apk del .build-deps

COPY . /usr/src/app/

COPY config/database.yml.prod config/database.yml

COPY .env.prod .env

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
