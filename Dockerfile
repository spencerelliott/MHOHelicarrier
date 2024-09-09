FROM docker.io/library/alpine

RUN apk update
RUN apk add git dotnet6-sdk sqlite caddy bash curl

RUN mkdir /mho

WORKDIR /mho

# Clone the latest version of the server into the container
RUN git clone https://github.com/Crypto137/MHServerEmu.git
WORKDIR MHServerEmu

RUN echo "Checking out branch ${SERVER_BRANCH}"
RUN git checkout $SERVER_BRANCH

# Build the server for the first time
RUN dotnet build MHServerEmu.sln

WORKDIR /mho

# Copy the necessary files over
COPY data/Calligraphy.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/
COPY data/mu_cdata.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/

# Copy the configuration
# COPY data/Config.BypassAuth.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini
COPY data/Config.Default.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini

# Copy Linux SQLite interop files
ADD data/sqlite/* /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/

# Copy necessary files to host the server
ADD web/ /mho/web

COPY Caddyfile /mho/Caddyfile

# COPY cli.sh /mho/cli.sh
# RUN chmod +x /mho/cli.sh

COPY server.sh /mho/server.sh
RUN chmod +x /mho/server.sh

RUN mkdir /mho/player_data

ENTRYPOINT ["bash", "server.sh"]

