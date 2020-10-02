
# Cassandra commands

nodetool status

cqlsh cassandra1 -u cassandra -p cassandra
    describe keyspaces
    create KEYSPACE ks1 WITH replication = {'class': 'NetworkTopologyStrategy', 'dc1':3};
    use ks1;

    create table val (sid text, ts timestamp, val1 int, val2 int, primary key (sid, ts) ) WITH CLUSTERING ORDER BY (ts desc) ;
    insert into val (sid, ts, val1, val2) values ('test1', '2019-01-01 12:00:01', 12,14);
    copy val to 'export.csv';
    

cassandra-stress write n=1000 cl=ONE    -mode native cql3 user=cassandra password=cassandra -node cassandra1

cassandra-stress read  n=1000 cl=QUORUM -mode native cql3 user=cassandra password=cassandra -node cassandra1
 
