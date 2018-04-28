
 HOSTNAME="$(hostname -i)"
 SOURCE_HOST=$1
 docker cp pg_hba.conf ldars-postgres-replica:/var/lib/postgresql/data
 docker exec -i ldars-postgres-replica psql -U postgres < readonlyuser.pgsql
 docker exec -i ldars-postgres-replica psql -U postgres < reloadpsql.pgsql

 echo "Configuring PGLOGICAL for Predix Services" 
 
 docker cp pglogical-em-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-pmpsql-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-tms-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-zac-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-uaa-subscriber.pgsql ldars-postgres-replica:/
 
 docker exec -i ldars-postgres-replica psql -d em-tenant-db  -U postgres -f pglogical-em-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=em-tenant-db'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=em-tenant-db'"
 docker exec -i ldars-postgres-replica psql -d pmpsql -U postgres -f pglogical-pmpsql-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=pm-psql'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=pm-psql'"
 docker exec -i ldars-postgres-replica psql -d tmsdb  -U postgres -f pglogical-tms-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=tmsdb'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=tmsdb'"
 docker exec -i ldars-postgres-replica psql -d zacdb  -U postgres -f pglogical-zac-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=zacdb'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=zacdb'"
docker exec -i ldars-postgres-replica psql -d uaadb  -U postgres -f pglogical-uaa-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=uaadb'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=uaadb'"

 echo "Configuring PGLOGICAL for Relayr Services"

 docker cp pglogical-pdm-subscriber.pgsql ldars-postgres-replica:/
 docker exec -i ldars-postgres-replica psql -d pdm  -U postgres -f pglogical-pdm-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=pdm'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=pdm'"

 echo "Configuring PGLOGICAL for GET Services"


 docker cp pglogical-ldarsbls-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ldarsacl-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-hpomidb-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ruledeploy-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ldarsreq-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ldarsnap-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ldarsqrtz-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-ldarsonboard-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-fleet-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-gis-subscriber.pgsql ldars-postgres-replica:/
 docker cp pglogical-gls-subscriber.pgsql ldars-postgres-replica:/



 docker exec -i ldars-postgres-replica psql -d ldarsbls -U ldarsadmin -f pglogical-ldarsbls-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsbls'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=ldarsbls'"
 docker exec -i ldars-postgres-replica psql -d ldarsacl -U ldarsadmin -f pglogical-ldarsacl-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsacl'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarsacl'"
 docker exec -i ldars-postgres-replica psql -d ldarshpomi -U ldarsadmin -f pglogical-hpomidb-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=ldarshpomi'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarshpomi'"
 docker exec -i ldars-postgres-replica psql -d ldarsrulesdeploy -U ldarsadmin -f pglogical-ruledeploy-subscriber.pgsql -v   target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsrulesdeploy'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarsrulesdeploy'"
 docker exec -i ldars-postgres-replica psql -d ldarsreq -U ldarsadmin -f pglogical-ldarsreq-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=ldarsreq'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarsreq'"
 docker exec -i ldars-postgres-replica psql -d postgres  -U ldarsadmin -f pglogical-ldarsnap-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=postgres'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=postgres'"
 docker exec -i ldars-postgres-replica psql -d ldarsqrtz -U ldarsadmin -f pglogical-ldarsqrtz-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432  dbname=ldarsqrtz'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarsqrtz'"
 docker exec -i ldars-postgres-replica psql -d ldarsonboardexporter -U ldarsadmin -f pglogical-ldarsonboard-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432   dbname=ldarsonboardexporter'" -v source_dsn="'host=$SOURCE_HOST port=5432  dbname=ldarsonboardexporter'"
docker exec -i ldars-postgres-replica psql -d ldarsfleet -U ldarsadmin -f pglogical-fleet-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsfleet'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=ldarsfleet'"
docker exec -i ldars-postgres-replica psql -d ldarsgis -U ldarsadmin -f pglogical-gis-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsgis'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=ldarsgis'"
docker exec -i ldars-postgres-replica psql -d ldarsgls -U ldarsadmin -f pglogical-gls-subscriber.pgsql -v  target_dsn="'host=$HOSTNAME port=5432 dbname=ldarsgls'" -v source_dsn="'host=$SOURCE_HOST  port=5432 dbname=ldarsgls'"


