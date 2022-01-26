FROM postgis/postgis:14-master

# tools+dependencies
RUN apt update && apt upgrade -y
RUN apt install python3 python3-pip nano htop -y
RUN pip install csvkit psycopg2-binary

#pgpass
RUN echo "localhost:5432:*:klarschiff:klarschiff" > /root/.pgpass; chmod 600 /root/.pgpass
#db, schema, user
COPY ./scripts /scripts
RUN mv /scripts/20_init_klarschiff.sql /docker-entrypoint-initdb.d/
