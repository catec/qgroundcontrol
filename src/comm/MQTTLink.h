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
 * @brief MQTT communications main class.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

// todo Eventually, this class might inherit from a higher one called MQTTLinkManager in charge of instanciating various MQTTLinks for
// multiple potential mqtt connections to different addresses.

#pragma once

#include <QObject>
#include <mqtt/async_client.h>

#include "QGCToolbox.h"
#include "QGCApplication.h"
#include "MQTTPublisher.h"

class MQTTPublisher;

class MQTTLink : public QObject
{
    Q_OBJECT

public:

    MQTTLink(QGCApplication* app, QGCToolbox* toolbox);
    virtual ~MQTTLink(); // todo check how to destroy this object

    void startMQTTClient();
    void stopMQTTClient();

    MQTTPublisher* mqttPublisher;

    std::unique_ptr<mqtt::async_client> mqttClient;

private:

    void _configureConnOptions();

    const std::string _serverProtocol;
    const std::string _serverIp;
    const std::string _serverPort;
    const std::string _clientId;
    const std::string _serverAddress;
    
    mqtt::connect_options _connOptions;

    QGCApplication* _app;
    QGCToolbox* _toolbox;
    
};