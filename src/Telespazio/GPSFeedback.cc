#include "GPSFeedback.h"

GPSFeedback::GPSFeedback(QObject * parent): 
    QObject(parent),
    _coordinate()
{
}

void GPSFeedback::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
        case MAVLINK_MSG_ID_GEOSUB_GPS_FEEDBACK:

            mavlink_geosub_gps_feedback_t gps_feedback;
            mavlink_msg_geosub_gps_feedback_decode(&message, &gps_feedback);

            if (_coordinate.latitude() != gps_feedback.lat || _coordinate.longitude() != gps_feedback.lon) 
                setCoordinate(QGeoCoordinate(gps_feedback.lat / 1e7, gps_feedback.lon / 1e7));

            break;

        default: 
            break;
    }
}

void GPSFeedback::setCoordinate(QGeoCoordinate value)
{
    _coordinate = value;
    emit coordinateChanged();
}
