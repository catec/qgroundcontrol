#include "gica.h"

GICA::GICA(QObject* parent): 
    QObject(parent),
    _linearPosX(0.0),
    _linearPosY(0.0),
    _linearPosZ(0.0),
    _linearVelX(0.0),
    _linearVelY(0.0),
    _linearVelZ(0.0),
    _linearAccX(0.0),
    _linearAccY(0.0),
    _linearAccZ(0.0),
    _angularPosRoll(0.0),
    _angularPosPitch(0.0),
    _angularPosYaw(0.0),
    _angularVelRoll(0.0),
    _angularVelPitch(0.0),
    _angularVelYaw(0.0),
    _angularAccRoll(0.0),
    _angularAccPitch(0.0),
    _angularAccYaw(0.0),
    _miscIntegrity(0.0),
    _miscNumSatVista(0),
    _miscSbasCorrection(false)
{
    // Connect the MavlinkReceiver's signal directly to the slot CustomTest::handleMavlinkMessage
    // connect(mavlinkReceiver, &MavlinkReceiver::messageReceived, this, &CustomTest::handleMavlinkMessage);
}

void GICA::handleMavlinkMessage(const mavlink_message_t& message)
{
    // TODO use this switch case instead
    // switch (message.msgid) {
    //     case MAVLINK_MSG_ID_XXXX: {
    //         mavlink_xxxx_t xxxx;
    //         mavlink_msg_xxxx_decode(&message, &xxxx);

    //         if (_linearPosX != xxxx.roll) {
    //             _linearPosX = xxxx.roll;
    //             emit linearPosXChanged();
    //         }
    //         if (_linearPosY != xxxx.pitch) {
    //             _linearPosY = xxxx.pitch;
    //             emit linearPosYChanged();
    //         }
    //         if (_linearPosZ != xxxx.yaw) {
    //             _linearPosZ = xxxx.yaw;
    //             emit linearPosZChanged();
    //         }
    //         break;
    //     }
    //     // Handle other messages...
    // }

    _linearPosX         = 8.8;
    emit linearPosXChanged();

    _linearPosY         = 8.8;
    emit linearPosYChanged();
    
    _linearPosZ         = 8.8;
    emit linearPosZChanged();
    
    _linearVelX         = 8.8;
    emit linearVelXChanged();
    
    _linearVelY         = 8.8;
    emit linearVelYChanged();
    
    _linearVelZ         = 8.8;
    emit linearVelZChanged();
    
    _linearAccX         = 8.8;
    emit linearAccXChanged();
    
    _linearAccY         = 8.8;
    emit linearAccYChanged();
    
    _linearAccZ         = 8.8;
    emit linearAccZChanged();
    
    _angularPosRoll     = 8.8;
    emit angularPosRollChanged();
    
    _angularPosPitch    = 8.8;
    emit angularPosPitchChanged();
    
    _angularPosYaw      = 8.8;
    emit angularPosYawChanged();
    
    _angularVelRoll     = 8.8;
    emit angularVelRollChanged();
    
    _angularVelPitch    = 8.8;
    emit angularVelPitchChanged();
    
    _angularVelYaw      = 8.8;
    emit angularVelYawChanged();
    
    _angularAccRoll     = 8.8;
    emit angularAccRollChanged();
    
    _angularAccPitch    = 8.8;
    emit angularAccPitchChanged();
    
    _angularAccYaw      = 8.8;
    emit angularAccYawChanged();

    _miscIntegrity      = 5.5;
    emit miscIntegrityChanged();
    
    _miscNumSatVista    = 12;
    emit miscNumSatVistaChanged();

    _miscSbasCorrection = true;
    emit miscSbasCorrectionChanged();

}
