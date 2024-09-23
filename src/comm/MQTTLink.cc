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
 * @brief MQTT communications main class implementation.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#include "MQTTLink.h"

MQTTLink::MQTTLink(QGCApplication* app, QGCToolbox* toolbox) :
    _serverProtocol("tcp"),
    _serverIp("127.0.0.1"), // todo Input this server info using an UI?
    _serverPort("15000"), // todo Ask port target
    _clientId("qgc_mqtt_client"), // todo give automatic client id's
    _serverAddress(_serverProtocol + "://" + _serverIp + ":" + _serverPort),
    _app(app),
    _toolbox(toolbox)
{
    mqttPublisher = new MQTTPublisher();
    
    mqttClient = std::make_unique<mqtt::async_client>(_serverAddress, _clientId);
    startMQTTClient();
}

MQTTLink::~MQTTLink()
{
    stopMQTTClient();

    delete mqttPublisher;
}

void MQTTLink::stopMQTTClient()
{
    try 
    {
        std::cout << "[MQTT INFO] Stopping MQTT link with server " << _serverIp << ":" << _serverPort << std::endl;

        if (mqttClient->is_connected())
        {
            mqttClient->disconnect()->wait();
            std::cout << "[MQTT INFO] MQTT link has been stopped." << std::endl;
        }
        else
        {
            std::cout << "[MQTT INFO] MQTT link was not open." << std::endl;
        }
    } 
    catch (const mqtt::exception& exc) 
    {
        std::cerr << "[MQTT ERROR] Error while stopping MQTT link: " << exc.what() << std::endl;
    }
}

void MQTTLink::_configureConnOptions()
{
    _connOptions.set_clean_session(true);
    _connOptions.set_automatic_reconnect(true);
}

void MQTTLink::startMQTTClient()
{
    _configureConnOptions();

    try 
    {    
        std::cout << "[MQTT INFO] Starting MQTT link with server " << _serverIp << ":" << _serverPort << std::endl;
        mqttClient->connect(_connOptions)->wait();
        std::cout << "[MQTT INFO] MQTT link has ben openned." << std::endl;
    } 
    catch (const mqtt::exception& exc) 
    {
        std::cerr << "[MQTT ERROR] Error while starting MQTT link: " << exc.what() << std::endl;
    }
}
