FROM java:8

COPY target/aks-hello-world-master.jar /aks-hello-world-master.jar
COPY config.yml /config.yml

CMD ["java", "-jar", "/aks-hello-world-master.jar", "server", "/config.yml"]
