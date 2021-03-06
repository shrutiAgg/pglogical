GRANT CONNECT ON DATABASE pdm  TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'pmdb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarspdm',    replication_sets := array['ldarspdm'],
  provider_dsn := :source_dsn);

