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

## Using Console Commands
To find the id of your container, type:  

`docker ps -a`  

This should provide you with a list of containers and their associated ID's. You will need to use the container id associated with the tag mentioned above when you performed the docker run command. In this example, it would be ajkayalan/rpi-spigotmc. Now attach to the container:  

`docker attach YourContainerIdHere`  

Now you can perform server console commands for the minecraft server. For example, to add yourself as an op, type:  

`op YourMinecraftNameHere`  

Remember to exit the attached container by pressing CTRL + P & CTRL Q. If you press CTRL + C, you will kill the container!  

## Installing Plugins
To install a plugin, first you must find where your data volume is located. To find the id of your container, type:  

`docker ps -a`  

This should provide you with a list of containers and their associated ID's.  Then inspect the container using:    

`docker inspect YourContainerIdHere`  

You should see a bunch of data come back. Under the "Mounts" section, you are looking for the path of the "Source" attribute on the item that has the "Destination" attribute set to "/data". Copy the source attribute path. From there, you can access the files by doing something like the following:  

`sudo -i`  
`cd /the/path/defined/in/the/destination/attribute`  

You can now modify your container's files as you wish. For instance, if I want to install a plugin and then restart the server, I can do something like the following:  

`cd plugins`  
`wget https://dev.bukkit.org/media/files/910/762/LaggRemover-0.2.2.jar`  
`docker restart YourContainerIdHere`  

## Docker Cleanup
If you played around building containers a lot, you may want to clear out orphaned volumes:  

`docker volume rm $(docker volume ls -qf dangling=true)`  

Note that this command is very powerful and should be used at your own risk.
