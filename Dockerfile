# Newer jessie images are busted
FROM resin/rpi-raspbian:jessie-20160831
MAINTAINER github.com/AjkayAlan

# Update package lists, install jre, and cleanup
RUN apt-get update \
    && apt-get install -y oracle-java8-jdk wget nano git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create volume to interact with
VOLUME ["/data"]

# Set workdir
WORKDIR /data

# Accept Mojang EULA
RUN echo "eula=TRUE" > eula.txt

# Silence harmless but scary sounding errors
RUN echo "[]" > banned-ips.json
RUN echo "[]" > banned-players.json
RUN echo "[]" > ops.json
RUN echo "[]" > usercache.json
RUN echo "[]" > whitelist.json

# Add server settings
ADD server.properties /data/

# Build latest spigot image
RUN mkdir /data/temp \
    && cd /data/temp \
    && wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
    && java -jar BuildTools.jar --rev latest

RUN mv /data/temp/spigot-*.jar /data/spigot_server.jar \
    && rm -rf /data/temp

# Expose the port needed to connect
EXPOSE 25565

CMD java -Xms512M -Xmx1008M -jar /data/spigot_server.jar nogui
