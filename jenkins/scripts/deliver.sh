#!/usr/bin/env bash
#摘取pom文件project.name,project.version
NAME=`mvn help:evaluate -Dexpression=project.artifactId | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`

#打印jar包路径日志
echo "JAR Path : ./target/${NAME}-${VERSION}.jar"

#杀死已存在进程
# if [ -n "$xxx" ]用于判断xxx变量非空
# fi为if语句的结束,相当于end if
pid=`ps -ef | grep ${NAME}-${VERSION}.jar|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]
then
  kill -9 $pid
  echo "${NAME}-${VERSION}.jar Killed"
fi

#运行jar包
#设定BUILD_ID防止被jenkins杀掉
export BUILD_ID=dontKillMe
#后台jar包启动,并将日志输出到application.log 文件
nohup java -Xms800m -Xmx800m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:MaxNewSize=512m -jar ./target/${NAME}-${VERSION}.jar 1>/var/lib/jenkins/workspace/application.log 2>&1 &

#打印启动成功日志
echo "${NAME}-${VERSION}.jar Start successful"