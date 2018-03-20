#!/bin/bash
/usr/local/hadoop/bin/hdfs namenode -format

/usr/local/hadoop/sbin/start-dfs.sh

hadoop fs -mkdir /user
hadoop fs -mkdir /user/vagrant
hadoop fs -mkdir /user/vagrant/input
hadoop fs -put ~/data /pig

hadoop fs -mkdir /tmp 
hadoop fs -mkdir /user/hive/warehouse
hadoop fs -chmod g+w /tmp 
hadoop fs -chmod g+w /user/hive/warehouse

/usr/local/hadoop/sbin/start-yarn.sh
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver

/usr/local/hive/bin/schematool -initSchema -dbType derby

pig src/pig/stack_etl.pig
hive -f src/sql/create_external_table.sql