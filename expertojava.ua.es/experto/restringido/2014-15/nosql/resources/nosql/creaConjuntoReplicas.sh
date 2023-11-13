#!/bin/bash

echo "Limpieza"
killall mongod

echo "Borrando datos previos"
rm -rf /data/db/rs*

echo "Creando carpetas"
mkdir -p /data/db/rs1 /data/db/rs2 /data/db/rs3 /data/logs

echo "Lanzando servicios mongod"
mongod --replSet replicaExperto --logpath /data/logs/rs1.log --dbpath /data/db/rs1 --port 27017 --oplogSize 64 --smallfiles --fork
mongod --replSet replicaExperto --logpath /data/logs/rs2.log --dbpath /data/db/rs2 --port 27018 --oplogSize 64 --smallfiles --fork
mongod --replSet replicaExperto --logpath /data/logs/rs3.log --dbpath /data/db/rs3 --port 27019 --oplogSize 64 --smallfiles --fork
