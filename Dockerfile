FROM gitlab.archlinux.org:5050/archlinux/archlinux-docker:base-master
RUN pacman -Syyu --noconfirm --noprogressbar --quiet \
    && pacman -S --noconfirm --noprogressbar --quiet base-devel gnupg \
    && mkdir -p /work && cd /work \
    && curl -s https://aur.archlinux.org/cgit/aur.git/snapshot/repoctl.tar.gz | tar -zxf - \
    && cd repoctl \
    && sed -i 's/(( EUID == 0 ))/false/' /usr/bin/makepkg \
    && makepkg --noconfirm --noprogressbar --syncdeps --install --rmdeps \
    && cd .. && rm -rf repoctl \
    && pacman -Rsnu --noconfirm --noprogressbar base-devel \
    && rm -rf /var/lib/pacman/sync/* \
    && rm -rf /var/cache/pacman/*
