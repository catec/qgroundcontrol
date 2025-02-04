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
 * @brief External Primecor data MAVLink receiver implementation.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#include "Primecor.h"
#include "MQTTPublisher.h"

Primecor::Primecor():
    _primecorTopic("mcm/2006C240100000000/v1.02/d2c")
{
}

void Primecor::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
        case MAVLINK_MSG_ID_GEOSUB_PRIMECOR:
        {
            mavlink_geosub_primecor_t geosub_primecor_data;
            mavlink_msg_geosub_primecor_decode(&message, &geosub_primecor_data);
            
            const std::string payload =
                std::to_string(geosub_primecor_data.msgID)      + "," +   std::to_string(geosub_primecor_data.hdr)        + "," + 
                               geosub_primecor_data.devSN       + "," +   std::to_string(geosub_primecor_data.batLvl)     + "," +
                std::to_string(geosub_primecor_data.rssi)       + "," +                  geosub_primecor_data.date        + "," + 
                               geosub_primecor_data.time        + "," +   std::to_string(geosub_primecor_data.lat)        + "," + 
                std::to_string(geosub_primecor_data.lng)        + "," +   std::to_string(geosub_primecor_data.altGps)     + "," + 
                std::to_string(geosub_primecor_data.hdop)       + "," +   std::to_string(geosub_primecor_data.velms)      + "," + 
                std::to_string(geosub_primecor_data.fixState)   + "," +                  geosub_primecor_data.cog         + "," + 
                std::to_string(geosub_primecor_data.numSat)     + "," +   std::to_string(geosub_primecor_data.pdop)       + "," + 
                std::to_string(geosub_primecor_data.vdop)       + "," +   std::to_string(geosub_primecor_data.pressBar)   + "," + 
                std::to_string(geosub_primecor_data.altBar)     + "," +   std::to_string(geosub_primecor_data.altAgl)     + "," + 
                std::to_string(geosub_primecor_data.altAmsl)    + "," +   std::to_string(geosub_primecor_data.tempBar)    + "," + 
                               geosub_primecor_data.end;

            std::cout << "MAVLINK_MSG_ID_GEOSUB_PRIMECOR Payload -> " << payload << std::endl; //! remove before merge

            emit publishMQTTData(_primecorTopic, payload);

            break;
        }

        default:
            break;
    }
}