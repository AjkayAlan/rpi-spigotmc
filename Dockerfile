FROM resin/rpi-raspbian:stretch
LABEL maintainer="github.com/AjkayAlan"

# Update package lists, install jre, and cleanup
RUN apt-get update \
    && apt-get install -y oracle-java8-jdk wget nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create volume and set workdir
WORKDIR /data

# Accept Mojang EULA
RUN echo "eula=TRUE" > eula.txt

# Add server settings
ADD server.properties /data/

# Get latest compiled build
RUN wget -O spigot_server.jar http://tcpr.ca/files/spigot/spigot-latest.jar

# Expose the port needed to connect
EXPOSE 25565

CMD java -Xms512M -Xmx1008M -jar /data/spigot_server.jar nogui
