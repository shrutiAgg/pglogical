
echo "Migrating GET Data"

docker exec -i  ldars-postgres-replice  psql -U postgres < get_ldars-acldb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-ruledeploy.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-reqdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-snapdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-onboardb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-qrtzdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-blsdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-hpomi.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-fleetdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-gisdb.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < get_ldars-glsdb.pgsql

echo "Migrating Predix Data"

docker exec -i  ldars-postgres-replica  psql -U postgres < get_px-pm.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < px_em-tenant-db_1.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < px_tmsdb_1.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < px_zacdb_1.pgsql
docker exec -i  ldars-postgres-replica  psql -U postgres < px_uaadb_1.pgsql

echo "Migrating Relayr Data"

docker exec -i  ldars-postgres-replica  psql -U postgres < ldars-pgs.pgsql

echo "Data Migration for container ldars-postgres-replica is completed"

