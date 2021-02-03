#!/usr/bin/env bash
#摘取pom文件project.name,project.version
NAME=`mvn help:evaluate -Dexpression=project.artifactId | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
#打印
echo "Path : ./target/${NAME}-${VERSION}.jar"
#运行jar包
BUILD_ID=DONTKILLME
java -jar ./target/${NAME}-${VERSION}.jar &
