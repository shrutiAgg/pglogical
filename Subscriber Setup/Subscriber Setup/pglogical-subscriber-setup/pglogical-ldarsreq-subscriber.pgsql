GRANT CONNECT ON DATABASE ldarsreq TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'reqdb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarsreq',    replication_sets := array['ldarsreq'],
  provider_dsn := :source_dsn);


