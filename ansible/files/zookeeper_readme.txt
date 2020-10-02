
# using Zookeeper CLI:
/usr/share/zookeeper/bin/zkCli.sh -server zk1:2181
      ls /

# four letter commands:
echo ruok | nc zk1 2181
echo stat | nc zk1 2181

