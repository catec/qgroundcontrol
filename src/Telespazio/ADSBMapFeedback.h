/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include <QObject>
// #include <QTimer>

#include "QGCMAVLink.h"
#include "LinkManager.h"

class ADSBMapFeedback : public QObject
{
    Q_OBJECT

    // Q_PROPERTY(qreal    connectionAvailable   READ    connectionAvailable   NOTIFY    connectionAvailableChanged)

    Q_PROPERTY(qreal    latitude            READ    latitude            NOTIFY    latitudeChanged)
    Q_PROPERTY(qreal    longitude           READ    longitude           NOTIFY    longitudeChanged)

public:

    explicit ADSBMapFeedback(QObject* parent = nullptr);

    // qreal    connectionAvailable   () const { return _connectionAvailable; }

    qreal    latitude            () const { return static_cast<qreal>(_latitude); }
    qreal    longitude           () const { return static_cast<qreal>(_longitude); }

signals:

    // void connectionAvailableChanged ();
    void latitudeChanged          ();
    void longitudeChanged         ();

public slots:

    void mavlinkMessageReceived(LinkInterface* link, mavlink_message_t message);

    // void connectionLost();
    // void connectionAlive();
    
private:

    // QTimer _messageTimeout;

    void setLatitude            (float value);
    void setLongitude           (float value);

    // float    _connectionAvailable;

    float    _latitude;
    float    _longitude;

};
