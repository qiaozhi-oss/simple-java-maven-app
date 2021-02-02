#!/usr/bin/env bash
#摘取pom文件project.name,project.version
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
#打印
echo ${NAME}-${VERSION}
#运行jar包
java -jar ./target/${NAME}-${VERSION}.jar
