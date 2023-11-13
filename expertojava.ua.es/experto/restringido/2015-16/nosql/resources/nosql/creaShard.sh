#!/bin/bash

echo "--- Limpieza"
killall mongod
killall mongos

echo "--- Borrando datos previos"
rm -rf /data/s1/db*
rm -rf /data/s2/db*
rm -rf /data/conf1/db

echo "--- Creando carpetas"
mkdir -p /data/s1/db /data/s2/db /data/conf1/db /data/logs

echo "--- Lanzandos 2 shards + servidor de configuración"
mongod --shardsvr --dbpath  /data/s1/db --port 27000 --logpath /data/logs/sh1.log --smallfiles --oplogSize 128 --fork
mongod --shardsvr --dbpath  /data/s2/db --port 27001 --logpath /data/logs/sh2.log --smallfiles --oplogSize 128 --fork
mongod --configsvr --dbpath  /data/conf1/db --port 25000 --logpath  /data/logs/config.log --fork
echo "--- Lanzandos mongos"
mongos --configdb localhost:25000 --logpath  /data/logs/mongos.log --fork
