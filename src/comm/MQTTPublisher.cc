/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

/** 
 * @file
 * @brief Publisher class implementation for MQTT communications.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#include "MQTTPublisher.h"

MQTTPublisher::MQTTPublisher(MQTTLink* mqttLink) :
    _mqttLink(mqttLink)
{
}

MQTTPublisher::~MQTTPublisher()
{
}

void MQTTPublisher::publishMQTTData(const std::string& topic, const std::string& payload) 
{
    try 
    {
        mqtt::message_ptr msg = mqtt::make_message(topic, payload);
        _mqttLink->mqttClient->publish(msg);
        // std::cout << "[MQTT INFO] Published message to topic: " << topic << std::endl;
    } 
    catch (const mqtt::exception& exc) 
    {
        std::cerr << "[MQTT ERROR] Failed to publish message to topic: " << topic 
            << exc.what() << std::endl;
    }
}
