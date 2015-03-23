FROM blackikeeagle/archlinux
MAINTAINER Ike Devolder, ike.devolder@gmail.com

RUN pacman -Syu --noconfirm quassel-core
RUN pacman -Scc --noconfirm

RUN groupmod -g 4001 quassel
RUN usermod -u 4001 quassel

USER quassel
EXPOSE 4242

ENTRYPOINT ["quasselcore", "--configdir=/var/lib/quassel/", "--listen=0.0.0.0"]
