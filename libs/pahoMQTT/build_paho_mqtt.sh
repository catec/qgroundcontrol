#!/bin/bash

set -e

PWD_DIR=$1
PAHO_MQTT_CPP_DIR="$PWD_DIR/libs/pahoMQTT/paho_mqtt_cpp"
PAHO_MQTT_C_DIR="$PWD_DIR/libs/pahoMQTT/paho_mqtt_cpp/src/externals/paho-mqtt-c"

if [ ! -d "$PAHO_MQTT_CPP_DIR" ]; then
  echo "Error: Paho MQTT C++ directory not found: $PAHO_MQTT_CPP_DIR"
  exit 1
fi

if [ ! -d "$PAHO_MQTT_C_DIR" ]; then
  echo "Error: Paho MQTT C directory not found: $PAHO_MQTT_C_DIR"
  exit 1
fi

echo "Building Paho MQTT C++..."
cd $PAHO_MQTT_CPP_DIR
cmake -Bbuild -H. -DPAHO_WITH_MQTT_C=ON -DPAHO_BUILD_STATIC=ON -DPAHO_BUILD_DOCUMENTATION=OFF -DPAHO_BUILD_SAMPLES=OFF
cmake --build build/

echo "Building Paho MQTT C..."
cd $PAHO_MQTT_C_DIR
cmake -Bbuild -H. -DPAHO_ENABLE_TESTING=OFF -DPAHO_BUILD_STATIC=ON -DPAHO_WITH_SSL=ON -DPAHO_HIGH_PERFORMANCE=ON
cmake --build build/

echo "Paho MQTT build completed successfully."
