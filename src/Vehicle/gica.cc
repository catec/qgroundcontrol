#include "gica.h"

GICA::GICA(QObject* parent): 
    QObject(parent),
    _linearPosX(0.0f),
    _linearPosY(0.0f),
    _linearPosZ(0.0f),
    _linearVelX(0.0f),
    _linearVelY(0.0f),
    _linearVelZ(0.0f),
    _linearAccX(0.0f),
    _linearAccY(0.0f),
    _linearAccZ(0.0f),
    _angularPosRoll(0.0f),
    _angularPosPitch(0.0f),
    _angularPosYaw(0.0f),
    _angularVelRoll(0.0f),
    _angularVelPitch(0.0f),
    _angularVelYaw(0.0f),
    _angularAccRoll(0.0f),
    _angularAccPitch(0.0f),
    _angularAccYaw(0.0f),
    _miscIntegrity(0.0f),
    _miscNumSat(0),
    _miscSbasCorrection(false)
{
}

void GICA::mavlinkMessageReceived([[maybe_unused]] LinkInterface* link, mavlink_message_t message)
{
    switch (message.msgid) 
    {
        case MAVLINK_MSG_ID_GEOSUB_LINEAR_VALUES:

            mavlink_geosub_linear_values_t linear_values;
            mavlink_msg_geosub_linear_values_decode(&message, &linear_values);

            if (_linearPosX != linear_values.x_pos) {
                _linearPosX = linear_values.x_pos;
                emit linearPosXChanged();
            }

            if (_linearPosY != linear_values.y_pos) {
                _linearPosY = linear_values.y_pos;
                emit linearPosYChanged();
            }

            if (_linearPosZ != linear_values.z_pos) {
                _linearPosZ = linear_values.z_pos;
                emit linearPosZChanged();
            }

            if (_linearVelX != linear_values.x_vel) {
                _linearVelX = linear_values.x_vel;
                emit linearVelXChanged();
            }

            if (_linearVelY != linear_values.y_vel) {
                _linearVelY = linear_values.y_vel;
                emit linearVelYChanged();
            }

            if (_linearVelZ != linear_values.z_vel) {
                _linearVelZ = linear_values.z_vel;
                emit linearVelZChanged();
            }

            if (_linearAccX != linear_values.x_acc) {
                _linearAccX = linear_values.x_acc;
                emit linearAccXChanged();
            }

            if (_linearAccY != linear_values.y_acc) {
                _linearAccY = linear_values.y_acc;
                emit linearAccYChanged();
            }

            if (_linearAccZ != linear_values.z_acc) {
                _linearAccZ = linear_values.z_acc;
                emit linearAccZChanged();
            }

            break;

        case MAVLINK_MSG_ID_GEOSUB_ANGULAR_VALUES:

            mavlink_geosub_angular_values_t angular_values;
            mavlink_msg_geosub_angular_values_decode(&message, &angular_values);
            
            if (_angularPosRoll != angular_values.roll_pos) {
                _angularPosRoll = angular_values.roll_pos;
                emit angularPosRollChanged();
            }

            if (_angularPosPitch != angular_values.pitch_pos) {
                _angularPosPitch = angular_values.pitch_pos;
                emit angularPosPitchChanged();
            }

            if (_angularPosYaw != angular_values.yaw_pos) {
                _angularPosYaw = angular_values.yaw_pos;
                emit angularPosYawChanged();
            }

            if (_angularVelRoll != angular_values.roll_vel) {
                _angularVelRoll = angular_values.roll_vel;
                emit angularVelRollChanged();
            }

            if (_angularVelPitch != angular_values.pitch_vel) {
                _angularVelPitch = angular_values.pitch_vel;
                emit angularVelPitchChanged();
            }

            if (_angularVelYaw != angular_values.yaw_vel) {
                _angularVelYaw = angular_values.yaw_vel;
                emit angularVelYawChanged();
            }

            if (_angularAccRoll != angular_values.roll_acc) {
                _angularAccRoll = angular_values.roll_acc;
                emit angularAccRollChanged();
            }

            if (_angularAccPitch != angular_values.pitch_acc) {
                _angularAccPitch = angular_values.pitch_acc;
                emit angularAccPitchChanged();
            }

            if (_angularAccYaw != angular_values.yaw_acc) {
                _angularAccYaw = angular_values.yaw_acc;
                emit angularAccYawChanged();
            }

            break;

        case MAVLINK_MSG_ID_GEOSUB_MISC_VALUES:
            
            mavlink_geosub_misc_values_t misc_values;
            mavlink_msg_geosub_misc_values_decode(&message, &misc_values);

            if (_miscIntegrity != misc_values.integrity) {
                _miscIntegrity = misc_values.integrity;
                emit miscIntegrityChanged();
            }

            if (_miscNumSat != misc_values.num_sat) {
                _miscNumSat = misc_values.num_sat;
                emit miscNumSatChanged();
            }

            if (_miscSbasCorrection != misc_values.sbas_correction) {
                _miscSbasCorrection = misc_values.sbas_correction;
                emit miscSbasCorrectionChanged();
            }
            
            break;

        default: 
            break;
    }
}
