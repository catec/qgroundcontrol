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
 * @brief External ADSB data MAVLink receiver.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#pragma once

#include <QObject>

#include "QGCMAVLink.h"
#include "LinkManager.h"

class ADSB : public QObject
{
    Q_OBJECT

public:

    ADSB();

signals:

    void publishMQTTData(const std::string& topic, const std::string& payload);

public slots:

    void mavlinkMessageReceived(LinkInterface* link, mavlink_message_t message);

private:

    const std::string _adsbTopic;

};
