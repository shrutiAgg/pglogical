GRANT CONNECT ON DATABASE ldarshpomi TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'hpomidb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarshpomi',replication_sets := array['ldarshpomi'],
  provider_dsn := :source_dsn);


