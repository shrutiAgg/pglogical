GRANT CONNECT ON DATABASE ldarsrulesdeploy  TO readonlyuser;
GRANT USAGE ON SCHEMA public TO readonlyuser;
GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;

CREATE EXTENSION pglogical;

SELECT pglogical.create_node(
    node_name := 'rulesdeploydb_subscriber',
    dsn := :target_dsn
);

SELECT pglogical.create_subscription(
 subscription_name := 'ldarsrulesdeploy',    replication_sets := array['ldarsrulesdeploy'],
  provider_dsn := :source_dsn);


