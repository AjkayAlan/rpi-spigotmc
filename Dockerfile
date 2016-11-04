# Newer jessie images are busted
FROM resin/rpi-raspbian:jessie-20160831
MAINTAINER github.com/AjkayAlan

# Update package lists, install jre, and cleanup
RUN apt-get update \
    && apt-get install -y oracle-java8-jdk wget nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /spigot

# Accept Mojang EULA
RUN echo "eula=TRUE" > eula.txt

# Silence harmless but scary sounding errors
RUN echo "[]" > banned-ips.json
RUN echo "[]" > banned-players.json
RUN echo "[]" > ops.json
RUN echo "[]" > usercache.json
RUN echo "[]" > whitelist.json

# Add server settings
ADD server.properties /spigot/

# Download compiled spigotmc host (building takes a long time)
RUN wget https://ci.mcadmin.net/job/Spigot/lastSuccessfulBuild/artifact/spigot-1.10.2.jar

# Expose the port needed to connect
EXPOSE 25565

CMD java -Xms512M -Xmx1008M -jar /spigot/spigot-1.10.2.jar nogui
