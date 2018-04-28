GRANT CONNECT ON DATABASE ldarsgis  TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'gisdb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarsgis',    replication_sets := array['ldarsgis'],
  provider_dsn := :source_dsn);

