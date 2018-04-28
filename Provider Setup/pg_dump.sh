

echo "Stopping Containers"

docker stop app-postgres-container


echo "Taking pg_dump of Services"

docker exec -u root postgres-db_1  pg_dumpall  -U postgres  > postgres-db_1.pgsql

