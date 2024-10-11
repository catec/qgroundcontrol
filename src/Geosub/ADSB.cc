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

#include <json.hpp>

ADSB::ADSB():
    _adsbTopic("gcs_qgc/ADSB")
{
}

void ADSB::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
        case MAVLINK_MSG_ID_GEOSUB_ADSB_IN:
        {
            mavlink_geosub_adsb_in_t adsb_in;
            mavlink_msg_geosub_adsb_in_decode(&message, &adsb_in);

            nlohmann::json j;
            j["icao24"]       = adsb_in.icao_address;
            j["latitude"]     = adsb_in.lat;
            j["longitude"]    = adsb_in.lon;
            j["altitude"]     = adsb_in.alt;
            j["heading"]      = adsb_in.heading;
            j["horVelocity"]  = adsb_in.hor_velocity;
            j["verVelocity"]  = adsb_in.ver_velocity;
            j["flags"]        = adsb_in.valid_flags;
            j["squawk"]       = adsb_in.squawk;
            j["altitudeType"] = adsb_in.altitude_type;
            j["callsign"]     = adsb_in.callsign;
            j["emitterType"]  = adsb_in.emitter_type;
            j["tslc"]         = adsb_in.tslc;

            const std::string payload = j.dump();

            emit publishMQTTData(_adsbTopic, payload);

            break;
        }

        case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_DYNAMIC:
        {
            mavlink_geosub_adsb_out_dynamic_t adsb_out_dynamic;
            mavlink_msg_geosub_adsb_out_dynamic_decode(&message, &adsb_out_dynamic);

            // nlohmann::json j;
            // j["utc_time"]     = adsb_out_dynamic.utc_time;
            // j["lat"]          = adsb_out_dynamic.lat;
            // j["lon"]          = adsb_out_dynamic.lon;
            // j["alt_pres"]     = adsb_out_dynamic.alt_pres;
            // j["alt_gnss"]     = adsb_out_dynamic.alt_gnss;
            // j["hor_acc"]      = adsb_out_dynamic.hor_acc;
            // j["ver_acc"]      = adsb_out_dynamic.ver_acc;
            // j["acc_vel"]      = adsb_out_dynamic.acc_vel;
            // j["ver_velocity"] = adsb_out_dynamic.ver_velocity;
            // j["ns_vog"]       = adsb_out_dynamic.ns_vog;
            // j["ew_vog"]       = adsb_out_dynamic.ew_vog;
            // j["state"]        = adsb_out_dynamic.state;
            // j["squawk"]       = adsb_out_dynamic.squawk;
            // j["fix_type"]     = adsb_out_dynamic.fix_type;
            // j["num_sats"]     = adsb_out_dynamic.num_sats;
            // j["em_status"]    = adsb_out_dynamic.em_status;
            // j["control"]      = adsb_out_dynamic.control;
    
            // const std::string payload = j.dump();

            // emit publishMQTTData(_adsbTopic, payload);
            
            break;
        }

        case MAVLINK_MSG_ID_GEOSUB_ADSB_OUT_STATIC:
        {
            mavlink_geosub_adsb_out_static_t adsb_out_static;
            mavlink_msg_geosub_adsb_out_static_decode(&message, &adsb_out_static);

            // nlohmann::json j;
            // j["ICAO_address"] = adsb_out_static.ICAO_address;
            // j["integrity"]    = adsb_out_static.integrity;
            // j["stall_speed"]  = adsb_out_static.stall_speed;
            // j["capability"]   = adsb_out_static.capability;
            // j["emitter"]      = adsb_out_static.emitter;
            // j["alw_encode"]   = adsb_out_static.alw_encode;
            // j["gps_lat_offs"] = adsb_out_static.gps_lat_offs;
            // j["gps_lon_offs"] = adsb_out_static.gps_lon_offs;
            
            // const std::string payload = j.dump();

            // emit publishMQTTData(_adsbTopic, payload);
            
            break;
        }

        default: 
            break;
    }
}