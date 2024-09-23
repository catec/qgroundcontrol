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
 * @brief External ADSB data MAVLink receiver implementation.
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#include "ADSB.h"
#include "MQTTPublisher.h"

ADSB::ADSB()
{
}

void ADSB::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
        case MAVLINK_MSG_ID_GEOSUB_ADSB_IN:

            mavlink_geosub_adsb_in_t adsb_in;
            mavlink_msg_geosub_adsb_in_decode(&message, &adsb_in);

            // Parse message and send it by signal to a slot in src/comm/mqtt/MQTTParser, which will make a JSON out of it
            // It will then forward it to MQTTPublisher which publishes that JSON data under a given topic
            // Previously, a class MQTTLink must start the mqtt connection with the server.
            // emit publishMQTTData("path/to/topic", "json:{data:values}");

            break;

        case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_DYNAMIC:

            mavlink_geosub_adsb_out_dynamic_t adsb_out_dynamic;
            mavlink_msg_geosub_adsb_out_dynamic_decode(&message, &adsb_out_dynamic);

            // Parse message and send it by signal to a slot in src/comm/mqtt/MQTTParser, which will make a JSON out of it
            // It will then forward it to MQTTPublisher which publishes that JSON data under a given topic
            // Previously, a class MQTTLink must start the mqtt connection with the server.

            break;

        case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_STATIC:

            mavlink_geosub_adsb_out_static_t adsb_out_static;
            mavlink_msg_geosub_adsb_out_static_decode(&message, &adsb_out_static);

            // Parse message and send it by signal to a slot in src/comm/mqtt/MQTTParser, which will make a JSON out of it
            // It will then forward it to MQTTPublisher which publishes that JSON data under a given topic
            // Previously, a class MQTTLink must start the mqtt connection with the server.

            break;

        default: 
            break;
    }
}