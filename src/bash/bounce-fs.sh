#!/bin/bash
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh stop historyserver
/usr/local/hadoop/sbin/stop-yarn.sh
/usr/local/hadoop/sbin/stop-dfs.sh
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver
