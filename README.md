# rpi-spigotmc
Raspberry Pi Docker Image for a SpigotMC Minecraft Server

## Building
Build the container using something like the following:  

`docker build -t ajkayalan/rpi-spigotmc:latest https://github.com/AjkayAlan/rpi-spigotmc.git`  

If you have cloned locally, you can do something like the following instead:  

`docker build -t ajkayalan/rpi-spigotmc:latest .`  

## Running
After building the container, you will want to run it.

`docker run -d -it --name rpi-spigotmc --restart always -v /data -p 25565:25565 ajkayalan/rpi-spigotmc:latest`
