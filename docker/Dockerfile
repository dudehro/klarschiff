FROM postgis/postgis:14-master

# scripts and tools
COPY ./scripts /scripts
RUN apt update && apt upgrade -y
RUN apt install python3 python3-pip  -y
RUN pip install csvkit

#pgpass
RUN echo "localhost:5432:*:postgres:postgres" > /root/.pgpass; chmod 600 /root/.pgpass

#RUN cat /usr/local/bin/docker-entrypoint.sh
