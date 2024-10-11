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
#include <QGeoCoordinate>
// #include <QTimer>

#include "QGCMAVLink.h"
#include "LinkManager.h"

class GPSFeedback : public QObject
{
    Q_OBJECT

    // Q_PROPERTY(qreal    connectionAvailable   READ    connectionAvailable   NOTIFY    connectionAvailableChanged)

    Q_PROPERTY(QGeoCoordinate       coordinate                  READ coordinate                NOTIFY coordinateChanged)

public:

    explicit GPSFeedback(QObject* parent = nullptr);

    // qreal    connectionAvailable   () const { return _connectionAvailable; }

    QGeoCoordinate    coordinate            () const { return _coordinate; }

signals:

    // void connectionAvailableChanged ();
    void coordinateChanged          ();

public slots:

    void mavlinkMessageReceived(LinkInterface* link, mavlink_message_t message);

    // void connectionLost();
    // void connectionAlive();
    
private:

    // QTimer _messageTimeout;

    void setCoordinate          (QGeoCoordinate value);

    // float    _connectionAvailable;

    QGeoCoordinate    _coordinate;

};
