COMMAND=$1

if [ "$COMMAND" = "bash" ]; then
    bash
elif [ "$COMMAND" = "server" ]; then
    echo "Starting MHO server..."
    caddy start
    ./MHServerEmu/src/MHServerEmu/bin/x64/Debug/net6.0/MHServerEmu
elif [ "$COMMAND" = "update" ]; then
    cd MHServerEmu
    git fetch
    git merge origin/master
    dotnet build MHServerEmu.sln
else
    echo "Command ${COMMAND} not recognized"
fi

