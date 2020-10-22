#!/usr/bin/env bash

CONFIG=$PWD/config

/usr/local/bin/kafka-server-start "$CONFIG/server-1.properties"
