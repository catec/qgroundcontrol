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

#include "QGCMAVLink.h"

class GICA : public QObject
{
    Q_OBJECT

public:

    GICA(QObject* parent = nullptr);

    // Linear
    Q_PROPERTY(double    linearPosX            READ    linearPosX            NOTIFY    linearPosXChanged)
    Q_PROPERTY(double    linearPosY            READ    linearPosY            NOTIFY    linearPosYChanged)
    Q_PROPERTY(double    linearPosZ            READ    linearPosZ            NOTIFY    linearPosZChanged)
    Q_PROPERTY(double    linearVelX            READ    linearVelX            NOTIFY    linearVelXChanged)
    Q_PROPERTY(double    linearVelY            READ    linearVelY            NOTIFY    linearVelYChanged)
    Q_PROPERTY(double    linearVelZ            READ    linearVelZ            NOTIFY    linearVelZChanged)
    Q_PROPERTY(double    linearAccX            READ    linearAccX            NOTIFY    linearAccXChanged)
    Q_PROPERTY(double    linearAccY            READ    linearAccY            NOTIFY    linearAccYChanged)
    Q_PROPERTY(double    linearAccZ            READ    linearAccZ            NOTIFY    linearAccZChanged)
    // Angular
    Q_PROPERTY(double    angularPosRoll        READ    angularPosRoll        NOTIFY    angularPosRollChanged)
    Q_PROPERTY(double    angularPosPitch       READ    angularPosPitch       NOTIFY    angularPosPitchChanged)
    Q_PROPERTY(double    angularPosYaw         READ    angularPosYaw         NOTIFY    angularPosYawChanged)
    Q_PROPERTY(double    angularVelRoll        READ    angularVelRoll        NOTIFY    angularVelRollChanged)
    Q_PROPERTY(double    angularVelPitch       READ    angularVelPitch       NOTIFY    angularVelPitchChanged)
    Q_PROPERTY(double    angularVelYaw         READ    angularVelYaw         NOTIFY    angularVelYawChanged)
    Q_PROPERTY(double    angularAccRoll        READ    angularAccRoll        NOTIFY    angularAccRollChanged)
    Q_PROPERTY(double    angularAccPitch       READ    angularAccPitch       NOTIFY    angularAccPitchChanged)
    Q_PROPERTY(double    angularAccYaw         READ    angularAccYaw         NOTIFY    angularAccYawChanged)
    // Misc
    Q_PROPERTY(double    miscIntegrity         READ    miscIntegrity         NOTIFY    miscIntegrityChanged)
    Q_PROPERTY(int       miscNumSatVista       READ    miscNumSatVista       NOTIFY    miscNumSatVistaChanged)
    Q_PROPERTY(bool      miscSbasCorrection    READ    miscSbasCorrection    NOTIFY    miscSbasCorrectionChanged)

    // Linear
    double    linearPosX            (void) const { return _linearPosX; }
    double    linearPosY            (void) const { return _linearPosY; }
    double    linearPosZ            (void) const { return _linearPosZ; }
    double    linearVelX            (void) const { return _linearVelX; }
    double    linearVelY            (void) const { return _linearVelY; }
    double    linearVelZ            (void) const { return _linearVelZ; }
    double    linearAccX            (void) const { return _linearAccX; }
    double    linearAccY            (void) const { return _linearAccY; }
    double    linearAccZ            (void) const { return _linearAccZ; }
    // Angular
    double    angularPosRoll        (void) const { return _angularPosRoll; }
    double    angularPosPitch       (void) const { return _angularPosPitch; }
    double    angularPosYaw         (void) const { return _angularPosYaw; }
    double    angularVelRoll        (void) const { return _angularVelRoll; }
    double    angularVelPitch       (void) const { return _angularVelPitch; }
    double    angularVelYaw         (void) const { return _angularVelYaw; }
    double    angularAccRoll        (void) const { return _angularAccRoll; }
    double    angularAccPitch       (void) const { return _angularAccPitch; }
    double    angularAccYaw         (void) const { return _angularAccYaw; }
    // Misc
    double    miscIntegrity         (void) const { return _miscIntegrity; }
    int       miscNumSatVista       (void) const { return _miscNumSatVista; }
    bool      miscSbasCorrection    (void) const { return _miscSbasCorrection; }

public slots:

    void handleMavlinkMessage(const mavlink_message_t& message);

signals:

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
    void miscNumSatVistaChanged     ();
    void miscSbasCorrectionChanged  ();

private:

    // Linear
    double    _linearPosX;
    double    _linearPosY;
    double    _linearPosZ;
    double    _linearVelX;
    double    _linearVelY;
    double    _linearVelZ;
    double    _linearAccX;
    double    _linearAccY;
    double    _linearAccZ;
    // Angular
    double    _angularPosRoll;
    double    _angularPosPitch;
    double    _angularPosYaw;
    double    _angularVelRoll;
    double    _angularVelPitch;
    double    _angularVelYaw;
    double    _angularAccRoll;
    double    _angularAccPitch;
    double    _angularAccYaw;
    // Misc
    double    _miscIntegrity;
    int       _miscNumSatVista;
    bool      _miscSbasCorrection;

};
