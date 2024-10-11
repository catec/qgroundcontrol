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
 * @brief Publisher class for MQTT communications.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#pragma once

#include <QObject>
#include <mqtt/async_client.h>

#include "MQTTLink.h"

class MQTTPublisher : public QObject
{
    Q_OBJECT

public:

    MQTTPublisher(MQTTLink* = nullptr);
    virtual ~MQTTPublisher(); // ?

public slots:

    void publishMQTTData(const std::string& topic, const std::string& payload);

private:

    MQTTLink* _mqttLink = nullptr;

};