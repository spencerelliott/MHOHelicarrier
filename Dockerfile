FROM docker.io/library/alpine

RUN apk update
RUN apk add git dotnet6-sdk sqlite caddy bash curl

RUN mkdir /mho

WORKDIR /mho

# Make sure we download the latest code
ARG CACHEBUST

# Clone the latest version of the server into the container
RUN git clone ${GIT_URL}
WORKDIR MHServerEmu

RUN echo "Checking out branch ${SERVER_BRANCH} from ${GIT_URL}"
RUN git checkout $SERVER_BRANCH

# Build the server for the first time
RUN dotnet build MHServerEmu.sln

WORKDIR /mho

# Copy the necessary files over
COPY data/Calligraphy.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/
COPY data/mu_cdata.sip /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Data/Game/

# Copy the configuration
COPY data/Config.IgnoreSessionToken.JSON.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini
# COPY data/Config.IgnoreSessionToken.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini
# COPY data/Config.Default.ini /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/Config.ini

# Copy Linux SQLite interop files
ADD data/sqlite/* /mho/MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/

# Copy necessary files to host the server
ADD web/ /mho/web

COPY Caddyfile /mho/Caddyfile

COPY server.sh /mho/server.sh
RUN chmod +x /mho/server.sh

RUN mkdir /mho/player_data

ENTRYPOINT ["bash", "server.sh"]

