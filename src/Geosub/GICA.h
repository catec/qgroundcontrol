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
 * @brief GICA widget (backend).
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#pragma once

#include <QObject>
#include <QTimer>

#include "QGCMAVLink.h"
#include "LinkManager.h"

class GICA : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal    connectionAvailable   READ    connectionAvailable   NOTIFY    connectionAvailableChanged)

    Q_PROPERTY(qreal    linearPosX            READ    linearPosX            NOTIFY    linearPosXChanged)
    Q_PROPERTY(qreal    linearPosY            READ    linearPosY            NOTIFY    linearPosYChanged)
    Q_PROPERTY(qreal    linearPosZ            READ    linearPosZ            NOTIFY    linearPosZChanged)
    Q_PROPERTY(qreal    linearVelX            READ    linearVelX            NOTIFY    linearVelXChanged)
    Q_PROPERTY(qreal    linearVelY            READ    linearVelY            NOTIFY    linearVelYChanged)
    Q_PROPERTY(qreal    linearVelZ            READ    linearVelZ            NOTIFY    linearVelZChanged)
    Q_PROPERTY(qreal    linearAccX            READ    linearAccX            NOTIFY    linearAccXChanged)
    Q_PROPERTY(qreal    linearAccY            READ    linearAccY            NOTIFY    linearAccYChanged)
    Q_PROPERTY(qreal    linearAccZ            READ    linearAccZ            NOTIFY    linearAccZChanged)
    
    Q_PROPERTY(qreal    angularPosRoll        READ    angularPosRoll        NOTIFY    angularPosRollChanged)
    Q_PROPERTY(qreal    angularPosPitch       READ    angularPosPitch       NOTIFY    angularPosPitchChanged)
    Q_PROPERTY(qreal    angularPosYaw         READ    angularPosYaw         NOTIFY    angularPosYawChanged)
    Q_PROPERTY(qreal    angularVelRoll        READ    angularVelRoll        NOTIFY    angularVelRollChanged)
    Q_PROPERTY(qreal    angularVelPitch       READ    angularVelPitch       NOTIFY    angularVelPitchChanged)
    Q_PROPERTY(qreal    angularVelYaw         READ    angularVelYaw         NOTIFY    angularVelYawChanged)
    Q_PROPERTY(qreal    angularAccRoll        READ    angularAccRoll        NOTIFY    angularAccRollChanged)
    Q_PROPERTY(qreal    angularAccPitch       READ    angularAccPitch       NOTIFY    angularAccPitchChanged)
    Q_PROPERTY(qreal    angularAccYaw         READ    angularAccYaw         NOTIFY    angularAccYawChanged)
    
    Q_PROPERTY(qreal    miscIntegrity         READ    miscIntegrity         NOTIFY    miscIntegrityChanged)
    Q_PROPERTY(int      miscNumSat            READ    miscNumSat            NOTIFY    miscNumSatChanged)
    Q_PROPERTY(bool     miscSbasCorrection    READ    miscSbasCorrection    NOTIFY    miscSbasCorrectionChanged)

public:

    explicit GICA(QObject* parent = nullptr);

    qreal    connectionAvailable   () const { return _connectionAvailable; }

    qreal    linearPosX            () const { return static_cast<qreal>(_linearPosX); }
    qreal    linearPosY            () const { return static_cast<qreal>(_linearPosY); }
    qreal    linearPosZ            () const { return static_cast<qreal>(_linearPosZ); }
    qreal    linearVelX            () const { return static_cast<qreal>(_linearVelX); }
    qreal    linearVelY            () const { return static_cast<qreal>(_linearVelY); }
    qreal    linearVelZ            () const { return static_cast<qreal>(_linearVelZ); }
    qreal    linearAccX            () const { return static_cast<qreal>(_linearAccX); }
    qreal    linearAccY            () const { return static_cast<qreal>(_linearAccY); }
    qreal    linearAccZ            () const { return static_cast<qreal>(_linearAccZ); }
    
    qreal    angularPosRoll        () const { return static_cast<qreal>(_angularPosRoll); }
    qreal    angularPosPitch       () const { return static_cast<qreal>(_angularPosPitch); }
    qreal    angularPosYaw         () const { return static_cast<qreal>(_angularPosYaw); }
    qreal    angularVelRoll        () const { return static_cast<qreal>(_angularVelRoll); }
    qreal    angularVelPitch       () const { return static_cast<qreal>(_angularVelPitch); }
    qreal    angularVelYaw         () const { return static_cast<qreal>(_angularVelYaw); }
    qreal    angularAccRoll        () const { return static_cast<qreal>(_angularAccRoll); }
    qreal    angularAccPitch       () const { return static_cast<qreal>(_angularAccPitch); }
    qreal    angularAccYaw         () const { return static_cast<qreal>(_angularAccYaw); }
    
    qreal    miscIntegrity         () const { return static_cast<qreal>(_miscIntegrity); }
    int      miscNumSat            () const { return _miscNumSat ; }
    bool     miscSbasCorrection    () const { return _miscSbasCorrection; }

signals:

    void connectionAvailableChanged ();
    void linearPosXChanged          ();
    void linearPosYChanged          ();
    void linearPosZChanged          ();
    void linearVelXChanged          ();
    void linearVelYChanged          ();
    void linearVelZChanged          ();
    void linearAccXChanged          ();
    void linearAccYChanged          ();
    void linearAccZChanged          ();

    void angularPosRollChanged      ();
    void angularPosPitchChanged     ();
    void angularPosYawChanged       ();
    void angularVelRollChanged      ();
    void angularVelPitchChanged     ();
    void angularVelYawChanged       ();
    void angularAccRollChanged      ();
    void angularAccPitchChanged     ();
    void angularAccYawChanged       ();

    void miscIntegrityChanged       ();
    void miscNumSatChanged          ();
    void miscSbasCorrectionChanged  ();

public slots:

    void mavlinkMessageReceived(LinkInterface* link, mavlink_message_t message);

    void connectionLost();
    void connectionAlive();
    
private:

    QTimer _messageTimeout;

    void setLinearPosX            (float value);
    void setLinearPosY            (float value);
    void setLinearPosZ            (float value);
    void setLinearVelX            (float value);
    void setLinearVelY            (float value);
    void setLinearVelZ            (float value);
    void setLinearAccX            (float value);
    void setLinearAccY            (float value);
    void setLinearAccZ            (float value);

    void setAngularPosRoll        (float value);
    void setAngularPosPitch       (float value);
    void setAngularPosYaw         (float value);
    void setAngularVelRoll        (float value);
    void setAngularVelPitch       (float value);
    void setAngularVelYaw         (float value);
    void setAngularAccRoll        (float value);
    void setAngularAccPitch       (float value);
    void setAngularAccYaw         (float value);

    void setMiscIntegrity         (float value);
    void setMiscNumSat            (int value);
    void setMiscSbasCorrection    (bool value);

    float    _connectionAvailable;

    float    _linearPosX;
    float    _linearPosY;
    float    _linearPosZ;
    float    _linearVelX;
    float    _linearVelY;
    float    _linearVelZ;
    float    _linearAccX;
    float    _linearAccY;
    float    _linearAccZ;
    
    float    _angularPosRoll;
    float    _angularPosPitch;
    float    _angularPosYaw;
    float    _angularVelRoll;
    float    _angularVelPitch;
    float    _angularVelYaw;
    float    _angularAccRoll;
    float    _angularAccPitch;
    float    _angularAccYaw;
    
    float    _miscIntegrity;
    int      _miscNumSat;
    bool     _miscSbasCorrection;

};
