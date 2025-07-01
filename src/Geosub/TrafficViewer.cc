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
 * @brief TrafficViewer widget implementation (backend).
 * @author Sergi Lucas Millan <sergi.lucas@pildo.com>
*/

#include "TrafficViewer.h"

TrafficViewer::TrafficViewer(QObject* parent):
    QObject(parent),
    _connectionAvailable(false),
    _ICAO(),
    _integrity(),
    _stallSpeed(),
    _callsign(),
    _capability(),
    _emitter(),
    _alwEncode(),
    _gpsLatOffs(),
    _gpsLonOffs(),
    _utctime(),
    _latitude(),
    _longitude(),
    _altPres(),
    _altGNSS(),
    _accHoriz(),
    _accVert(),
    _accVel(),
    _velVert(),
    _nsVog(),
    _ewVog(),
    _state(),
    _squawk(),
    _fixType(),
    _numSats(),
    _emStatus(),
    _control(),
    m_aircraftModel(new AircraftListModel(this)),
    _clickedAircraftCallsign(""),
    _callsignClicked(""),
    _latitudeClicked(0.0f),
    _longitudeClicked(0.0f),
    _altitudeClicked(0.0f),
    _headingClicked(0.0f),
    _hVelocityClicked(0.0f),
    _vVelocityClicked(0.0f),
    _validFlagsClicked(false),
    _altitudeTypeClicked(""),
    _emitterTypeClicked(""),
    _tslcClicked(0)
{
    _messageTimeout.setInterval(1000); // 1s
    _messageTimeout.setSingleShot(true);
    connect(&_messageTimeout, &QTimer::timeout, this, &TrafficViewer::connectionLost);

    _adsbUpdateTimer.setInterval(1000);
    _adsbUpdateTimer.setSingleShot(false);
    connect(&_adsbUpdateTimer, &QTimer::timeout, this, &TrafficViewer::cleanADSBData);
    _adsbUpdateTimer.start();
}



void TrafficViewer::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid)
    {
    case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_STATIC:{
        mavlink_geosub_adsb_out_static_t static_values;
        mavlink_msg_geosub_adsb_out_static_decode(&message, &static_values);

        QString newICAO = QString("%1%2%3")
                .arg(static_values.ICAO_address[0], 2, 16, QLatin1Char('0'))
                .arg(static_values.ICAO_address[1], 2, 16, QLatin1Char('0'))
                .arg(static_values.ICAO_address[2], 2, 16, QLatin1Char('0'))
                .toUpper();
        if (_ICAO != newICAO) setICAO(newICAO);
        if (_integrity != static_values.integrity) setIntegrity(static_values.integrity);
        if (_stallSpeed != static_values.stall_speed) setStallSpeed(static_values.stall_speed);
        if (_callsign != static_values.callsign) setCallsign(static_values.callsign);
        if (_capability != static_values.capability) setCapability(static_values.capability);
        if (_emitter != static_values.emitter) setEmitter(static_values.emitter);
        if (_alwEncode != static_values.alw_encode) setAlwEncode(static_values.alw_encode);
        if (_gpsLatOffs != static_values.gps_lat_offs) setGpsLatOffs(static_values.gps_lat_offs);
        if (_gpsLonOffs != static_values.gps_lon_offs) setGpsLonOffs(static_values.gps_lon_offs);

        _staticMessageUpdateTimestamp = QDateTime::currentDateTimeUtc();

        connectionAlive();

        break;
    }

    case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_DYNAMIC: {
        mavlink_geosub_adsb_out_dynamic_t dynamic_values;
        mavlink_msg_geosub_adsb_out_dynamic_decode(&message, &dynamic_values);

        if (_utctime != dynamic_values.utc_time) setUtctime(dynamic_values.utc_time);
        if (_latitude != dynamic_values.lat)
            setLatitude(std::round((dynamic_values.lat / 1e7) * 1000.0) / 1000.0);
        if (_longitude != dynamic_values.lon)
            setLongitude(std::round((dynamic_values.lon / 1e7) * 1000.0) / 1000.0);
        if (_altPres != dynamic_values.alt_gnss) setAltPres(dynamic_values.alt_gnss);
        if (_altGNSS != dynamic_values.alt_pres) setAltGNSS(dynamic_values.alt_pres);
        if (_accHoriz != dynamic_values.hor_acc) setAccHoriz(dynamic_values.hor_acc);
        if (_accVert != dynamic_values.ver_acc) setAccVert(dynamic_values.ver_acc);
        if (_accVel != dynamic_values.ver_acc) setAccVel(dynamic_values.ver_acc);
        if (_velVert != dynamic_values.ver_velocity) setVelVert(dynamic_values.ver_velocity);
        if (_nsVog != dynamic_values.ns_vog) setNsVog(dynamic_values.ns_vog);
        if (_ewVog != dynamic_values.ew_vog) setEwVog(dynamic_values.ew_vog);
        if (_state != dynamic_values.state) setState(dynamic_values.state);
        if (_squawk != dynamic_values.squawk) setSquawk(dynamic_values.squawk);
        if (_fixType != dynamic_values.fix_type) setFixType(dynamic_values.fix_type);
        if (_numSats != dynamic_values.num_sats) setNumSats(dynamic_values.num_sats);
        if (_emStatus != dynamic_values.em_status) setEmStatus(dynamic_values.em_status);
        if (_control != dynamic_values.control) setControl(dynamic_values.control);

        _dynamicMessageUpdateTimestamp = QDateTime::currentDateTimeUtc();

        connectionAlive();

        break;
    }

    case MAVLINK_MSG_ID_GEOSUB_ADSB_IN: {
        mavlink_geosub_adsb_in_t adsb_values;
        mavlink_msg_geosub_adsb_in_decode(&message, &adsb_values);

        updateAircraftMap(adsb_values);

        connectionAlive();

        break;

    }

    default:
        break;
    }
}


void TrafficViewer::updateAircraftMap(const mavlink_geosub_adsb_in_t& adsb_values)
{
    AircraftData data;

    // 1. Callsign: de char[9] a QString (asegúrate de que esté bien terminado en null)
    data.callsign = QString::fromLatin1(adsb_values.callsign).trimmed();

    // 2. Lat/Lon: de int32 (en 1e7 grados) a double (en grados)
    data.latitude = static_cast<double>(adsb_values.lat) / 1e7;
    data.longitude = static_cast<double>(adsb_values.lon) / 1e7;

    // 3. Altitude: suponiendo que es en centímetros → pasa a metros
    data.altitude = static_cast<float>(adsb_values.alt) / 100.0f;

    // 4. Heading: centidegrees → grados
    data.heading = static_cast<float>(adsb_values.heading) / 100.0f;

    // 5. Velocidades horizontales y verticales: normalmente en cm/s → m/s
    data.hVelocity = static_cast<float>(adsb_values.hor_velocity) / 100.0f;
    data.vVelocity = static_cast<float>(adsb_values.ver_velocity) / 100.0f;

    // 6. Valid flags: suponiendo que basta con saber si es no nulo
    data.validFlags = (adsb_values.valid_flags != 0);

    // 7. Altitude type: conversión opcional (enum → string)
    switch (adsb_values.altitude_type) {
    case 0: data.altitudeType = "Pressure QNH"; break;
    case 1: data.altitudeType = "Geometric"; break;
    default: data.altitudeType = "Unknown"; break;
    }

    // 8. Emitter type: también puede ser un enum
    switch (adsb_values.emitter_type) {
    case 0: data.emitterType = "No Info"; break;
    case 1: data.emitterType = "Light"; break;
    case 2: data.emitterType = "Small"; break;
    case 3: data.emitterType = "Large"; break;
    case 4: data.emitterType = "High Vortex Aircraft"; break;
    case 5: data.emitterType = "Heavy"; break;
    case 6: data.emitterType = "Highly Maneuverable"; break;
    case 7: data.emitterType = "Rotorcraft"; break;
    case 8: data.emitterType = "Glider/Sailplane"; break;
    case 9: data.emitterType = "Lighter-than-air"; break;
    case 10: data.emitterType = "Unmanned Aerial Vehicle"; break;
    case 11: data.emitterType = "Space/Transatmospheric vehicle"; break;
    case 12: data.emitterType = "Ultralight/Hang-glider/Paraglider"; break;
    case 13: data.emitterType = "Parachutist/Skydiver"; break;
    case 14: data.emitterType = "Unknown"; break;
    case 15: data.emitterType = "Space vehicle"; break;
    case 16: data.emitterType = "Emergency vehicle"; break;
    case 17: data.emitterType = "Service vehicle"; break;
    case 18: data.emitterType = "Point Obstacle"; break;
    case 19: data.emitterType = "Cluster Obstacle"; break;
    case 20: data.emitterType = "Line Obstacle"; break;
    default: data.emitterType = "Unknown"; break;
    }

    // 9. TSLc (time since last communication): entero directamente
    data.tslc = static_cast<int>(adsb_values.tslc);

    if(_clickedAircraftCallsign == data.callsign){
        if (_callsignClicked != data.callsign) setCallsignClicked(data.callsign);
        if (_latitudeClicked != data.latitude) setLatitudeClicked(data.latitude);
        if (_longitudeClicked != data.longitude) setLongitudeClicked(data.longitude);
        if (_altitudeClicked != data.altitude) setAltitudeClicked(data.altitude);
        if (_headingClicked != data.heading) setHeadingClicked(data.heading);
        if (_hVelocityClicked != data.hVelocity) setHVelocityClicked(data.hVelocity);
        if (_vVelocityClicked != data.vVelocity) setVVelocityClicked(data.vVelocity);
        if (_altitudeTypeClicked != data.altitudeType) setAltitudeTypeClicked(data.altitudeType);
        if (_emitterTypeClicked != data.emitterType) setEmitterTypeClicked(data.emitterType);
        if (_tslcClicked != data.tslc) setTslcClicked(data.tslc);
    }

    m_aircraftModel->addOrUpdateAircraft(data);

    // Registrar o actualizar la hora actual de actualización
    m_aircraftUpdateTimestamps[data.callsign] = QDateTime::currentDateTimeUtc();
}


void TrafficViewer::cleanADSBData(){
    const QDateTime now = QDateTime::currentDateTimeUtc();
    QList<QString> toRemove;

    // Identificar los que han expirado
    for (auto it = m_aircraftUpdateTimestamps.cbegin(); it != m_aircraftUpdateTimestamps.cend(); ++it) {
        if (it.value().secsTo(now) > 10) {
            toRemove.append(it.key());
        }
    }

    // Eliminar de todas las estructuras
    for (const QString& callsign : toRemove) {
        m_aircraftModel->removeAircraft(callsign);
        m_aircraftMap.remove(callsign);
        m_aircraftUpdateTimestamps.remove(callsign);

        if ( callsign == _clickedAircraftCallsign){
            _clickedAircraftCallsign = "";
        }
    }

    // Eliminar marker dynamic del mapa
    if(_dynamicMessageUpdateTimestamp.secsTo(now) > 10){
        setLatitude(0.0);
        setLongitude(0.0);
    }

}


void TrafficViewer::connectionAlive()
{
    _messageTimeout.start(); // restarts the qtimer timeout

    if (!_connectionAvailable)
    {
        _connectionAvailable = true;
        emit connectionAvailableChanged();
    }
}

void TrafficViewer::connectionLost()
{
    if (_connectionAvailable)
    {
        _connectionAvailable = false;
        emit connectionAvailableChanged();
    }
}

void TrafficViewer::setICAO(const QString& value)
{
    _ICAO = value;
    emit ICAOChanged();
}

void TrafficViewer::setIntegrity(int value)
{
    _integrity = value;
    emit integrityChanged();
}

void TrafficViewer::setStallSpeed(int value)
{
    _stallSpeed = value;
    emit stallSpeedChanged();
}

void TrafficViewer::setCallsign(const QString& value)
{
    _callsign = value;
    emit callsignChanged();
}

void TrafficViewer::setCapability(int value)
{
    _capability = value;
    emit capabilityChanged();
}

void TrafficViewer::setEmitter(int value)
{
    _emitter = value;
    emit emitterChanged();
}

void TrafficViewer::setAlwEncode(int value)
{
    _alwEncode = value;
    emit alwEncodeChanged();
}

void TrafficViewer::setGpsLatOffs(int value)
{
    _gpsLatOffs = value;
    emit gpsLatOffsChanged();
}

void TrafficViewer::setGpsLonOffs(int value)
{
    _gpsLonOffs = value;
    emit gpsLonOffsChanged();
}

void TrafficViewer::setUtctime(uint32_t value)
{
    if (_utctime == value)
        return;

    _utctime = value;

    // Formatea la hora en string (HH:mm:ss)
    std::time_t rawTime = static_cast<time_t>(value);
    std::tm * ptm = std::gmtime(&rawTime);  // UTC

    char buffer[9]; // HH:mm:ss + '\0'
    std::strftime(buffer, sizeof(buffer), "%H:%M:%S", ptm);
    _utctimeStr = QString::fromUtf8(buffer);

    emit utctimeChanged();     // Si tienes Q_PROPERTY para uint32_t
    emit utctimeStrChanged();  // Para la propiedad string
}

void TrafficViewer::setLatitude(float value)
{
    _latitude = value;
    emit latitudeChanged();
}

void TrafficViewer::setLongitude(float value)
{
    _longitude = value;
    emit longitudeChanged();
}

void TrafficViewer::setAltPres(float value)
{
    _altPres = value;
    emit altPresChanged();
}

void TrafficViewer::setAltGNSS(float value)
{
    _altGNSS = value;
    emit altGNSSChanged();
}

void TrafficViewer::setAccHoriz(float value)
{
    _accHoriz = value;
    emit accHorizChanged();
}

void TrafficViewer::setAccVert(float value)
{
    _accVert = value;
    emit accVertChanged();
}

void TrafficViewer::setAccVel(float value)
{
    _accVel = value;
    emit accVelChanged();
}

void TrafficViewer::setVelVert(float value)
{
    _velVert = value;
    emit velVertChanged();
}

void TrafficViewer::setNsVog(float value)
{
    _nsVog = value;
    emit nsVogChanged();
}

void TrafficViewer::setEwVog(float value)
{
    _ewVog = value;
    emit ewVogChanged();
}

void TrafficViewer::setState(int value)
{
    _state = value;
    emit stateChanged();
}

void TrafficViewer::setSquawk(int value)
{
    _squawk = value;
    emit squawkChanged();
}

void TrafficViewer::setFixType(int value)
{
    _fixType = value;
    emit fixTypeChanged();
}

void TrafficViewer::setNumSats(int value)
{
    _numSats = value;
    emit numSatsChanged();
}

void TrafficViewer::setEmStatus(int value)
{
    _emStatus = value;
    emit emStatusChanged();
}

void TrafficViewer::setControl(int value)
{
    _control = value;
    emit controlChanged();
}


AircraftListModel* TrafficViewer::aircraftListModel() const
{
    return m_aircraftModel.data();
}

void TrafficViewer::setClickedAircraftCallsign(QString value)
{
    _clickedAircraftCallsign = value;
    emit clickedAircraftCallsignChanged();
}

void TrafficViewer::setCallsignClicked(QString value){
    _callsignClicked = value;
    emit callsignClickedChanged();
}
void TrafficViewer::setLatitudeClicked(double value){
    _latitudeClicked = value;
    emit latitudeClickedChanged();
}
void TrafficViewer::setLongitudeClicked(double value){
    _longitudeClicked = value;
    emit longitudeClickedChanged();
}
void TrafficViewer::setAltitudeClicked(double value){
    _altitudeClicked = value;
    emit altitudeClickedChanged();
}
void TrafficViewer::setHeadingClicked(double value){
    _headingClicked = value;
    emit headingClickedChanged();
}
void TrafficViewer::setHVelocityClicked(double value){
    _hVelocityClicked = value;
    emit hVelocityClickedChanged();
}
void TrafficViewer::setVVelocityClicked(double value){
    _vVelocityClicked = value;
    emit vVelocityClickedChanged();
}
void TrafficViewer::setValidFlagsClicked(bool value){
    _validFlagsClicked = value;
    emit validFlagsClickedChanged();
}
void TrafficViewer::setAltitudeTypeClicked(QString value){
    _altitudeTypeClicked = value;
    emit altitudeTypeClickedChanged();
}
void TrafficViewer::setEmitterTypeClicked(QString value){
    _emitterTypeClicked = value;
    emit emitterTypeClickedChanged();
}
void TrafficViewer::setTslcClicked(int value){
    _tslcClicked = value;
    emit tslcClickedChanged();
}

