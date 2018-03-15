#!/bin/bash
/usr/local/hadoop/bin/hdfs namenode -format

/usr/local/hadoop/sbin/start-dfs.sh

hadoop fs -mkdir /user
hadoop fs -mkdir /user/vagrant
hadoop fs -mkdir /user/vagrant/input
hadoop fs -put ~/data /pig

/usr/local/hadoop/sbin/start-yarn.sh
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver
