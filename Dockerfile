FROM docker.io/library/alpine

RUN apk update
RUN apk add git dotnet6-sdk sqlite caddy bash

RUN mkdir /mho


WORKDIR /mho

# Clone the latest version of the server into the container
RUN git clone https://github.com/Crypto137/MHServerEmu.git
WORKDIR MHServerEmu

# Build the server for the first time
RUN dotnet build MHServerEmu.sln

WORKDIR /mho

# Copy the necessary files over
COPY data/Calligraphy.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/
COPY data/mu_cdata.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/

# Copy the configuration
COPY data/Config.BypassAuth.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini

# Copy necessary files to host the server
ADD web/ /mho/web
COPY Caddyfile /mho/Caddyfile
COPY cli.sh /mho/cli.sh

RUN chmod +x /mho/cli.sh

ENTRYPOINT ["bash", "cli.sh"]

