GRANT CONNECT ON DATABASE db1 TO readonlyuser;


GRANT USAGE ON SCHEMA public TO readonlyuser;


GRANT SELECT ON ALL TABLES in SCHEMA  public TO readonlyuser;



CREATE EXTENSION pglogical;



SELECT pglogical.create_node(
 node_name := 'db_subscriber',
  dsn := :target_dsn
);



SELECT pglogical.create_subscription(
 subscription_name := 'db1',    replication_sets := array['db1'],
  provider_dsn := :source_dsn);



