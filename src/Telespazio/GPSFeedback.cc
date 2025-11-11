#include "GPSFeedback.h"

#include <cmath>
#include <iostream>
#include <random>

struct CoordinateTPZ {
  double latitude;
  double longitude;
};

void metersToDegrees(double lat_deg, double error_m, double &dlat_deg,
                     double &dlon_deg) {
  constexpr double meters_per_deg_lat = 111320.0;
  double lat_rad = lat_deg * M_PI / 180.0;
  dlat_deg = error_m / meters_per_deg_lat;
  dlon_deg = error_m / (meters_per_deg_lat * std::cos(lat_rad));
}

CoordinateTPZ randomCoordinate(double baseLat, double baseLon, double error_m) {
  double dlat, dlon;
  metersToDegrees(baseLat, error_m, dlat, dlon);

  // Generador aleatorio
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<> distLat(baseLat - dlat, baseLat + dlat);
  std::uniform_real_distribution<> distLon(baseLon - dlon, baseLon + dlon);

  return {distLat(gen), distLon(gen)};
}

GPSFeedback::GPSFeedback(QObject *parent)
    : QObject(parent), _coordinate(), _heading(0.0) {}

void GPSFeedback::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
    case MAVLINK_MSG_ID_GEOSUB_GPS_FEEDBACK: {
      mavlink_geosub_gps_feedback_t gps_feedback;
      mavlink_msg_geosub_gps_feedback_decode(&message, &gps_feedback);

      CoordinateTPZ coor =
          randomCoordinate(gps_feedback.lat, gps_feedback.lon, 2.5);
      setCoordinate(QGeoCoordinate(coor.latitude / 1e7, coor.longitude / 1e7));
      break;
    }

    case MAVLINK_MSG_ID_GLOBAL_POSITION_INT:

    {

      mavlink_global_position_int_t global_pos;
      mavlink_msg_global_position_int_decode(&message, &global_pos);

      if (global_pos.hdg != UINT16_MAX) {
        setHeading(global_pos.hdg / 100.0);
      }
      break;
    }

    default:
      break;
    }
}

void GPSFeedback::setCoordinate(QGeoCoordinate value)
{
    _coordinate = value;
    emit coordinateChanged();
}

void GPSFeedback::setHeading(double value) {
  _heading = value;
  emit headingChanged();
}