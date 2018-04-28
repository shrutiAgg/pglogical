CREATE EXTENSION PGLOGICAL;



SELECT pglogical.create_node(
node_name := 'db1_provider',
    dsn := :source_dsn
);



SELECT pglogical.create_replication_set(
set_name := 'db1',
    replicate_insert := TRUE, replicate_update := TRUE,
    replicate_delete := TRUE, replicate_truncate := TRUE
);



SELECT pglogical.replication_set_add_all_tables(
'db1', '{public}', TRUE);

