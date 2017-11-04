FROM bmoorman/ubuntu

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /opt/Ombi

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends wget curl jq unzip mono-devel && \
    fileUrl=$(curl --silent --location "https://api.github.com/repos/tidusjar/Ombi/releases" | jq -r '.[0].assets[].browser_download_url') && \
    wget --quiet --directory-prefix /tmp "${fileUrl}" && \
    unzip -q /tmp/Ombi.zip && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["mono", "/opt/Ombi/Release/Ombi.exe"]

EXPOSE 3579
