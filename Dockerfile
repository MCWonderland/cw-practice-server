#handling copy file stuff
FROM alpine AS fileMixer

WORKDIR /data

COPY ./server-snapshot .

RUN chmod -R 777 /data

#server runtime
FROM itzg/minecraft-server:java8-multiarch
WORKDIR /data
COPY --from=fileMixer /data .

ENV EULA=TRUE \
		TYPE=CUSTOM \
		MEMORY=2G \
		CUSTOM_SERVER=taco-spigot.jar \

		#constant settings
		PORT=25565 \
		ALLOW_NETHER=false \
		SPAWN_PROTECTION=0 \
		ONLINE_MODE=true \

		#config variables
		REPLACE_ENV_IN_PLACE=true \
