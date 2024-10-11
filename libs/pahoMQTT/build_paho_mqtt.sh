#!/bin/bash

set -e

SOURCE_DIR=$1
PAHO_MQTT_CPP_DIR="$SOURCE_DIR/libs/pahoMQTT/paho_mqtt_cpp"
PAHO_MQTT_C_DIR="$SOURCE_DIR/libs/pahoMQTT/paho_mqtt_cpp/src/externals/paho-mqtt-c"
STAGING_DIR="/project/build/staging"

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
cmake -Bbuild -H. -DPAHO_WITH_MQTT_C=ON -DPAHO_BUILD_STATIC=OFF -DPAHO_WITH_SSL=OFF -DPAHO_BUILD_DOCUMENTATION=OFF -DPAHO_BUILD_SAMPLES=OFF
cmake --build build/

echo "Building Paho MQTT C..."
cd $PAHO_MQTT_C_DIR
cmake -Bbuild -H. -DPAHO_ENABLE_TESTING=OFF -DPAHO_BUILD_STATIC=OFF -DPAHO_WITH_SSL=OFF -DPAHO_HIGH_PERFORMANCE=ON
cmake --build build/

echo "Paho MQTT build completed successfully."

# Create folder for paho libs within build/staging
mkdir -p $STAGING_DIR/pahoMQTT/libs
PAHO_MQTT_LIBS_DIR="$STAGING_DIR/pahoMQTT/libs"

# Copy libraries to the folder
cp "$PAHO_MQTT_CPP_DIR/build/src/libpaho-mqttpp3.so.1.3.1" "$PAHO_MQTT_LIBS_DIR/libpaho-mqttpp3.so.1.3.1"
cp "$PAHO_MQTT_C_DIR/build/src/libpaho-mqtt3a.so.1.3.13" "$PAHO_MQTT_LIBS_DIR/libpaho-mqtt3a.so.1.3.13"

# Move to the directory where copied libraries are, so the symblink will be relative to that path
cd $PAHO_MQTT_LIBS_DIR

# Make the necessary symblinks
ln -sf libpaho-mqttpp3.so.1.3.1  libpaho-mqttpp3.so.1
ln -sf libpaho-mqttpp3.so.1      libpaho-mqttpp3.so
ln -sf libpaho-mqtt3a.so.1.3.13 libpaho-mqtt3a.so.1
ln -sf libpaho-mqtt3a.so.1      libpaho-mqtt3a.so
