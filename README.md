# MHO Helicarrier

This project aims to containerize the MHServerEmu server so it can be run on any computer easily

More instructions will be posted here soon.

## Getting Started

### Podman

Download [podman](https://podman.io) on to your computer. These instructions should work on Mac, Linux, and Windows without much modification. Once podman is
fully set up (make sure to read through installation instructions thoroughly), the next steps can be followed.

### Finding the Necessary Files

In order to build the image, both the `mu_cdata.sip` and `Calligraphy.sip` files will need to be copied into the `data/` folder of this project. These files can be found in
the `Data/` folder of your Marvel Heroes installation. These instructions will not provide any instructions on how to download the client. After copying the files into the `data/`
folder, move on to the next step.

### Set up the Container Image

Open your preferred terminal (e.g. PowerShell, iTerm2, Konsole) and navigate to the folder of this project (using `cd`). Once in the correct folder, run the following command:

```bash
./BuildImage.sh
```

This will handle pulling the latest Alpine Linux image, downloading and building the MHServerEmu code, setting up the necessary server proxy, and uploading the needed
configuration files the server will require. Once the image has been successfully been built, the server can now be run!

### Running the Server

#### Steam Deck-specific Instructions

Since podman runs without root on the Steam Deck, the following command must be run once before starting the server for the first time:

```bash
sudo sysctl net.ipv4.ip_unprivileged_port_start=80`
```

This will allow podman to bind to the necessary ports on your computer to be able to run the server.

#### Starting the Server

Now that the image has been built, the server is ready to go! Run the following command in your terminal to run the server:

```bash
./RunServer.sh
```

This will start up the podman image and start the MHServerEmu server. At this point, the client can be run and used to connect to our server.

### Shutting Down the Server

To shut down the server, hit CTRL-C in the terminal. This will end the server sessions and gracefully shut down the rest of the image.

### Connecting a Client

#### Steam Deck-specific Instructions

The client needs to be patched before it can connect to our server. Download GHex from the Discovery store in Desktop Mode on the Steam Deck. Find
MarvelHeroesOmega.exe in your Marvel Heroes installation (`UnrealEngine3/Binaries/`), make a backup copy, and open the original with GHex. In the
menu for GHex, select "Jump to Byte" and enter `0x19B317E` and change `75` to `EB`. Select "Save As" and overwrite MarvelHeroesOmega.exe.

#### General Instructions

Run the Marvel Heroes client with the following command line parameters:

```bash
-robocopy -nosteam -siteconfigurl=localhost/SiteConfig.xml -emailaddress=test@test.com -password=123
```

This project defaults to bypassing the authentication process so users do not need to create an account before starting the game. All of the player's
data will be stored in the `player_data/` folder.

