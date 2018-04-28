
HOSTNAME="$(hostname -i)"
 
SOURCE_HOST=$1
 

docker cp pg_hba.conf lpostgres-db-subscriber:/var/lib/postgresql/data
 

docker exec -i postgres-db-subscriber psql -U postgres < readonlyuser.pgsql
 

docker exec -i postgres-db-subscriber psql -U postgres < reloadpsql.pgsql

 

echo "Configuring PGLOGICAL for Subscriber Services" 
 
 

docker cp pglogical-db1-subscriber.pgsql postgres-db-subscriber:/
 


docker exec -i postgres-db-subscriber psql -d db1  -U postgres -f pglogical-db1-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=db1'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=db1'"
 
