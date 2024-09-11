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
 * @brief GICA widget implementation (backend).
 * @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

#include "GICA.h"

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

            if (_linearPosX != linear_values.x_pos) setLinearPosX(linear_values.x_pos);
            if (_linearPosY != linear_values.y_pos) setLinearPosY(linear_values.y_pos);
            if (_linearPosZ != linear_values.z_pos) setLinearPosZ(linear_values.z_pos);
            if (_linearVelX != linear_values.x_vel) setLinearVelX(linear_values.x_vel);
            if (_linearVelY != linear_values.y_vel) setLinearVelY(linear_values.y_vel);
            if (_linearVelZ != linear_values.z_vel) setLinearVelZ(linear_values.z_vel);
            if (_linearAccX != linear_values.x_acc) setLinearAccX(linear_values.x_acc);
            if (_linearAccY != linear_values.y_acc) setLinearAccY(linear_values.y_acc);
            if (_linearAccZ != linear_values.z_acc) setLinearAccZ(linear_values.z_acc);

            break;

        case MAVLINK_MSG_ID_GEOSUB_ANGULAR_VALUES:

            mavlink_geosub_angular_values_t angular_values;
            mavlink_msg_geosub_angular_values_decode(&message, &angular_values);
            
            if (_angularPosRoll  != angular_values.roll_pos)  setAngularPosRoll(angular_values.roll_pos);
            if (_angularPosPitch != angular_values.pitch_pos) setAngularPosPitch(angular_values.pitch_pos);
            if (_angularPosYaw   != angular_values.yaw_pos)   setAngularPosYaw(angular_values.yaw_pos);
            if (_angularVelRoll  != angular_values.roll_vel)  setAngularVelRoll(angular_values.roll_vel);
            if (_angularVelPitch != angular_values.pitch_vel) setAngularVelPitch(angular_values.pitch_vel);
            if (_angularVelYaw   != angular_values.yaw_vel)   setAngularVelYaw(angular_values.yaw_vel);
            if (_angularAccRoll  != angular_values.roll_acc)  setAngularAccRoll(angular_values.roll_acc);
            if (_angularAccPitch != angular_values.pitch_acc) setAngularAccPitch(angular_values.pitch_acc);
            if (_angularAccYaw   != angular_values.yaw_acc)   setAngularAccYaw(angular_values.yaw_acc);

            break;

        case MAVLINK_MSG_ID_GEOSUB_MISC_VALUES:
            
            mavlink_geosub_misc_values_t misc_values;
            mavlink_msg_geosub_misc_values_decode(&message, &misc_values);

            if (_miscIntegrity      != misc_values.integrity)       setMiscIntegrity(misc_values.integrity);
            if (_miscNumSat         != misc_values.num_sat)         setMiscNumSat(misc_values.num_sat);
            if (_miscSbasCorrection != misc_values.sbas_correction) setMiscSbasCorrection(misc_values.sbas_correction);
            
            break;

        default: 
            break;
    }
}

void GICA::setLinearPosX(float value)
{
    _linearPosX = value;
    emit linearPosXChanged();
}

void GICA::setLinearPosY(float value)
{    
    _linearPosY = value;
    emit linearPosYChanged();
}

void GICA::setLinearPosZ(float value)
{
    _linearPosZ = value;
    emit linearPosZChanged();
}

void GICA::setLinearVelX(float value)
{    
    _linearVelX = value;
    emit linearVelXChanged();
}

void GICA::setLinearVelY(float value)
{    
    _linearVelY = value;
    emit linearVelYChanged();
}

void GICA::setLinearVelZ(float value)
{    
    _linearVelZ = value;
    emit linearVelZChanged();
}

void GICA::setLinearAccX(float value)
{    
    _linearAccX = value;
    emit linearAccXChanged();
}

void GICA::setLinearAccY(float value)
{    
    _linearAccY = value;
    emit linearAccYChanged();
}

void GICA::setLinearAccZ(float value)
{    
    _linearAccZ = value;
    emit linearAccZChanged();
}

void GICA::setAngularPosRoll(float value)
{
    _angularPosRoll = value;
    emit angularPosRollChanged();
}

void GICA::setAngularPosPitch(float value)
{    
    _angularPosPitch = value;
    emit angularPosPitchChanged();
}

void GICA::setAngularPosYaw(float value)
{
    _angularPosYaw = value;
    emit angularPosYawChanged();
}

void GICA::setAngularVelRoll(float value)
{
    _angularVelRoll = value;
    emit angularVelRollChanged();
}

void GICA::setAngularVelPitch(float value)
{    
    _angularVelPitch = value;
    emit angularVelPitchChanged();
}

void GICA::setAngularVelYaw(float value)
{
    _angularVelYaw = value;
    emit angularVelYawChanged();
}

void GICA::setAngularAccRoll(float value)
{
    _angularAccRoll = value;
    emit angularAccRollChanged();
}

void GICA::setAngularAccPitch(float value)
{    
    _angularAccPitch = value;
    emit angularAccPitchChanged();
}

void GICA::setAngularAccYaw(float value)
{
    _angularAccYaw = value;
    emit angularAccYawChanged();
}

void GICA::setMiscIntegrity(float value)
{
    _miscIntegrity = value;
    emit miscIntegrityChanged();
}

void GICA::setMiscNumSat(int value)
{    
    _miscNumSat = value;
    emit miscNumSatChanged();
}

void GICA::setMiscSbasCorrection(bool value)
{
    _miscSbasCorrection = value;
    emit miscSbasCorrectionChanged();
}
