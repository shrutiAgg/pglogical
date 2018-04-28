GRANT CONNECT ON DATABASE pm-psql  TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'pmpsqldb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarspmcommand',    replication_sets := array['ldarspmcommand'],
  provider_dsn := :source_dsn);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarspmuser',    replication_sets := array['ldarspmuser'],
  provider_dsn := :source_dsn);


