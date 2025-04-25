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
 * @brief TrafficViewer widget (backend).
 * @author Sergi Lucas Millan <sergi.lucas@pildo.com>
*/

#pragma once

#include <QObject>
#include <QTimer>
#include <QMap>
#include <QString>

#include "QGCMAVLink.h"
#include "LinkManager.h"
#include <QMetaType>
#include <QScopedPointer>
#include "AircraftListModel.h"

class TrafficViewer : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal    connectionAvailable   READ    connectionAvailable   NOTIFY    connectionAvailableChanged)

    Q_PROPERTY(QString ICAO READ ICAO NOTIFY ICAOChanged)
    Q_PROPERTY(int integrity READ integrity NOTIFY integrityChanged)
    Q_PROPERTY(int stallSpeed READ stallSpeed NOTIFY stallSpeedChanged)
    Q_PROPERTY(QString callsign READ callsign NOTIFY callsignChanged)
    Q_PROPERTY(int capability READ capability NOTIFY capabilityChanged)
    Q_PROPERTY(int emitter READ emitter NOTIFY emitterChanged)
    Q_PROPERTY(int alwEncode READ alwEncode NOTIFY alwEncodeChanged)
    Q_PROPERTY(int gpsLatOffs READ gpsLatOffs NOTIFY gpsLatOffsChanged)
    Q_PROPERTY(int gpsLonOffs READ gpsLonOffs NOTIFY gpsLonOffsChanged)

    Q_PROPERTY(uint32_t utctime READ utctime NOTIFY utctimeChanged)
    Q_PROPERTY(QString utctimeStr READ utctimeStr NOTIFY utctimeStrChanged)
    Q_PROPERTY(float latitude READ latitude NOTIFY latitudeChanged)
    Q_PROPERTY(float longitude READ longitude NOTIFY longitudeChanged)
    Q_PROPERTY(float altPres READ altPres NOTIFY altPresChanged)
    Q_PROPERTY(float altGNSS READ altGNSS NOTIFY altGNSSChanged)
    Q_PROPERTY(float accHoriz READ accHoriz NOTIFY accHorizChanged)
    Q_PROPERTY(float accVert READ accVert NOTIFY accVertChanged)
    Q_PROPERTY(float accVel READ accVel NOTIFY accVelChanged)
    Q_PROPERTY(float velVert READ velVert NOTIFY velVertChanged)
    Q_PROPERTY(float nsVog READ nsVog NOTIFY nsVogChanged)
    Q_PROPERTY(float ewVog READ ewVog NOTIFY ewVogChanged)
    Q_PROPERTY(int state READ state NOTIFY stateChanged)
    Q_PROPERTY(int squawk READ squawk NOTIFY squawkChanged)
    Q_PROPERTY(int fixType READ fixType NOTIFY fixTypeChanged)
    Q_PROPERTY(int numSats READ numSats NOTIFY numSatsChanged)
    Q_PROPERTY(int emStatus READ emStatus NOTIFY emStatusChanged)
    Q_PROPERTY(int control READ control NOTIFY controlChanged)

    Q_PROPERTY(AircraftListModel* aircraftListModel READ aircraftListModel NOTIFY aircraftListChanged)

    Q_PROPERTY(QString clickedAircraftCallsign READ clickedAircraftCallsign WRITE setClickedAircraftCallsign NOTIFY clickedAircraftCallsignChanged)

    Q_PROPERTY(QString callsignClicked READ callsignClicked NOTIFY callsignClickedChanged)
    Q_PROPERTY(double latitudeClicked READ latitudeClicked NOTIFY latitudeClickedChanged)
    Q_PROPERTY(double longitudeClicked READ longitudeClicked NOTIFY longitudeClickedChanged)
    Q_PROPERTY(double altitudeClicked READ altitudeClicked NOTIFY altitudeClickedChanged)
    Q_PROPERTY(double headingClicked READ headingClicked NOTIFY headingClickedChanged)
    Q_PROPERTY(double hVelocityClicked READ hVelocityClicked NOTIFY hVelocityClickedChanged)
    Q_PROPERTY(double vVelocityClicked READ vVelocityClicked NOTIFY vVelocityClickedChanged)
    Q_PROPERTY(bool validFlagsClicked READ validFlagsClicked NOTIFY validFlagsClickedChanged)
    Q_PROPERTY(QString altitudeTypeClicked READ altitudeTypeClicked NOTIFY altitudeTypeClickedChanged)
    Q_PROPERTY(QString emitterTypeClicked READ emitterTypeClicked NOTIFY emitterTypeClickedChanged)
    Q_PROPERTY(int tslcClicked READ tslcClicked NOTIFY tslcClickedChanged)


public:

    explicit TrafficViewer(QObject* parent = nullptr);

    qreal    connectionAvailable   () const { return _connectionAvailable; }

    QString ICAO() const { return _ICAO; }
    int integrity() const { return _integrity; }
    int stallSpeed() const { return _stallSpeed; }
    QString callsign() const { return _callsign; }
    int capability() const { return _capability; }
    int emitter() const { return _emitter; }
    int alwEncode() const { return _alwEncode; }
    int gpsLatOffs() const { return _gpsLatOffs; }
    int gpsLonOffs() const { return _gpsLonOffs; }

    uint32_t utctime() const { return _utctime; }
    QString utctimeStr() const { return _utctimeStr; }
    float latitude() const { return _latitude; }
    float longitude() const { return _longitude; }
    float altPres() const { return _altPres; }
    float altGNSS() const { return _altGNSS; }
    float accHoriz() const { return _accHoriz; }
    float accVert() const { return _accVert; }
    float accVel() const { return _accVel; }
    float velVert() const { return _velVert; }
    float nsVog() const { return _nsVog; }
    float ewVog() const { return _ewVog; }
    int state() const { return _state; }
    int squawk() const { return _squawk; }
    int fixType() const { return _fixType; }
    int numSats() const { return _numSats; }
    int emStatus() const { return _emStatus; }
    int control() const { return _control; }

    QString callsignClicked() const { return _callsignClicked; }
    double latitudeClicked() const { return _latitudeClicked; }
    double longitudeClicked() const { return _longitudeClicked; }
    double altitudeClicked() const { return _altitudeClicked; }
    double headingClicked() const { return _headingClicked; }
    double hVelocityClicked() const { return _hVelocityClicked; }
    double vVelocityClicked() const { return _vVelocityClicked; }
    bool validFlagsClicked() const { return _validFlagsClicked; }
    QString altitudeTypeClicked() const { return _altitudeTypeClicked; }
    QString emitterTypeClicked() const { return _emitterTypeClicked; }
    int tslcClicked() const { return _tslcClicked; }

    QString clickedAircraftCallsign() const { return _clickedAircraftCallsign; }

    void updateAircraftMap(const mavlink_geosub_adsb_in_t& adsb_values);

    AircraftListModel* aircraftListModel() const;
    void updateAircraftList();

signals:

    void connectionAvailableChanged ();

    void ICAOChanged();
    void integrityChanged();
    void stallSpeedChanged();
    void callsignChanged();
    void capabilityChanged();
    void emitterChanged();
    void alwEncodeChanged();
    void gpsLatOffsChanged();
    void gpsLonOffsChanged();

    void utctimeChanged();
    void utctimeStrChanged();
    void latitudeChanged();
    void longitudeChanged();
    void altPresChanged();
    void altGNSSChanged();
    void accHorizChanged();
    void accVertChanged();
    void accVelChanged();
    void velVertChanged();
    void nsVogChanged();
    void ewVogChanged();

    void stateChanged();
    void squawkChanged();
    void fixTypeChanged();
    void numSatsChanged();
    void emStatusChanged();
    void controlChanged();

    void aircraftListChanged();

    void clickedAircraftCallsignChanged();

    void callsignClickedChanged();
    void latitudeClickedChanged();
    void longitudeClickedChanged();
    void altitudeClickedChanged();
    void headingClickedChanged();
    void hVelocityClickedChanged();
    void vVelocityClickedChanged();
    void validFlagsClickedChanged();
    void altitudeTypeClickedChanged();
    void emitterTypeClickedChanged();
    void tslcClickedChanged();

public slots:

    void mavlinkMessageReceived(LinkInterface* link, mavlink_message_t message);

    void connectionLost();
    void connectionAlive();

    void cleanADSBData();

private:

    QTimer _messageTimeout;
    QTimer _adsbUpdateTimer;

    void setICAO                (const QString& value);
    void setIntegrity           (int value);
    void setStallSpeed          (int value);
    void setCallsign            (const QString& value);
    void setCapability          (int value);
    void setEmitter             (int value);
    void setAlwEncode           (int value);
    void setGpsLatOffs          (int value);
    void setGpsLonOffs          (int value);
    
    void setUtctime             (uint32_t value);
    void setLatitude            (float value);
    void setLongitude           (float value);
    void setAltPres             (float value);
    void setAltGNSS             (float value);
    void setAccHoriz            (float value);
    void setAccVert             (float value);
    void setAccVel              (float value);
    void setVelVert             (float value);
    void setNsVog               (float value);
    void setEwVog               (float value);
    void setState               (int value);
    void setSquawk              (int value);
    void setFixType             (int value);
    void setNumSats             (int value);
    void setEmStatus            (int value);
    void setControl             (int value);

    //void setClickedAircraft     (AircraftData& value);
    void setClickedAircraftCallsign (QString value);

    void setCallsignClicked(QString value);
    void setLatitudeClicked(double value);
    void setLongitudeClicked(double value);
    void setAltitudeClicked(double value);
    void setHeadingClicked(double value);
    void setHVelocityClicked(double value);
    void setVVelocityClicked(double value);
    void setValidFlagsClicked(bool value);
    void setAltitudeTypeClicked(QString value);
    void setEmitterTypeClicked(QString value);
    void setTslcClicked(int value);

    float    _connectionAvailable;

    QString _ICAO;
    int _integrity;
    int _stallSpeed;
    QString _callsign;
    int _capability;
    int _emitter;
    int _alwEncode;
    int _gpsLatOffs;
    int _gpsLonOffs;

    uint32_t _utctime;
    QString _utctimeStr;
    float _latitude;
    float _longitude;
    float _altPres;
    float _altGNSS;
    float _accHoriz;
    float _accVert;
    float _accVel;
    float _velVert;
    float _nsVog;
    float _ewVog;
    int _state;
    int _squawk;
    int _fixType;
    int _numSats;
    int _emStatus;
    int _control;

    QScopedPointer<AircraftListModel> m_aircraftModel;
    QMap<QString, AircraftData> m_aircraftMap;

    QMap<QString, QDateTime> m_aircraftUpdateTimestamps;
    QDateTime _staticMessageUpdateTimestamp;
    QDateTime _dynamicMessageUpdateTimestamp;

    QString _clickedAircraftCallsign;

    QString _callsignClicked;
    double _latitudeClicked;
    double _longitudeClicked;
    double _altitudeClicked;
    double _headingClicked;
    double _hVelocityClicked;
    double _vVelocityClicked;
    bool _validFlagsClicked;
    QString _altitudeTypeClicked;
    QString _emitterTypeClicked;
    int _tslcClicked;

};
