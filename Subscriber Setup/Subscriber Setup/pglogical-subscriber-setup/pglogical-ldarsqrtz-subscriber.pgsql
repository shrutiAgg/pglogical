GRANT CONNECT ON DATABASE ldarsqrtz TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'qrtzdb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarsqrtz',    replication_sets := array['ldarsqrtz'],
  provider_dsn := :source_dsn);


