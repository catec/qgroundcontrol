import QtQuick                      2.11
import QtQuick.Controls             2.4
import QtQuick.Controls.Styles      1.4
import QtQuick.Dialogs              1.2
import QtQuick.Layouts              1.11

import QGroundControl               1.0
import QGroundControl.Palette       1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Vehicle       1.0

ColumnLayout {

    GICA {
        id: gicaInstance
    }

    property double linearPosX : gicaInstance.linearPosX
    property double linearPosY : gicaInstance.linearPosY
    property double linearPosZ : gicaInstance.linearPosZ
    property double linearVelX : gicaInstance.linearVelX
    property double linearVelY : gicaInstance.linearVelY
    property double linearVelZ : gicaInstance.linearVelZ
    property double linearAccX : gicaInstance.linearAccX
    property double linearAccY : gicaInstance.linearAccY
    property double linearAccZ : gicaInstance.linearAccZ

    property double angularPosRoll  : gicaInstance.angularPosRoll
    property double angularPosPitch : gicaInstance.angularPosPitch
    property double angularPosYaw   : gicaInstance.angularPosYaw
    property double angularVelRoll  : gicaInstance.angularVelRoll
    property double angularVelPitch : gicaInstance.angularVelPitch
    property double angularVelYaw   : gicaInstance.angularVelYaw
    property double angularAccRoll  : gicaInstance.angularAccRoll
    property double angularAccPitch : gicaInstance.angularAccPitch
    property double angularAccYaw   : gicaInstance.angularAccYaw

    property double miscIntegrity    : gicaInstance.miscIntegrity
    property int miscNumSatVista     : gicaInstance.miscNumSatVista
    property bool miscSbasCorrection : gicaInstance.miscSbasCorrection

    property real dataDisplayHeight : 25
    property real dataDisplayWidth  : 100

    anchors.fill: parent

    TabBar {
        id: bar
        width: parent.width
        spacing: 0
        TabButton {
            text: qsTr("Linear values")
            width: implicitWidth
            onClicked: stackView.currentIndex = 0
            background: Rectangle {
                color: bar.currentIndex == 0 ? "white" : "gray"
                border.width: 1
                border.color: bar.currentIndex == 0 ? "black" : "transparent"
            }
        }
        
        TabButton {
            text: qsTr("Angular values")
            width: implicitWidth
            onClicked: stackView.currentIndex = 1
            background: Rectangle {
                color: bar.currentIndex == 1 ? "white" : "gray"
                border.width: 1
                border.color: bar.currentIndex == 1 ? "black" : "transparent"
            }
        }
        
        TabButton {
            text: qsTr("Misc")
            width: implicitWidth
            onClicked: stackView.currentIndex = 2
            background: Rectangle {
                color: bar.currentIndex == 2 ? "white" : "gray"
                border.width: 1
                border.color: bar.currentIndex == 2 ? "black" : "transparent"
            }
        }

    }

    StackLayout {
        id: stackView

        // Linear tab content
        Item {

            RowLayout {
                spacing: 15
                anchors.leftMargin: 10
                anchors.left: parent.left


                // Position
                Rectangle { 
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Position:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15

                                Rectangle {
                                    width: xLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: xLabelPos
                                        text: "X:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yLabelPos
                                        text: "Y:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: zLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: zLabelPos
                                        text: "Z:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Linear position x value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearPosX.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear position y value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearPosY.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear position z value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearPosZ.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }
                
                // Velocity
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Velocity:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15
                                Rectangle {
                                    width: xLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: xLabelVel
                                        text: "X:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yLabelVel
                                        text: "Y:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: zLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: zLabelVel
                                        text: "Z:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Linear velocity x value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearVelX.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear velocity y value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearVelY.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear velocity z value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearVelZ.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }

                // Acceleration
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Acceleration:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15
                                
                                Rectangle {
                                    width: xLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: xLabelAcc
                                        text: "X:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yLabelAcc
                                        text: "Y:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: zLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: zLabelAcc
                                        text: "Z:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Linear acceleration x value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearAccX.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear acceleration y value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearAccY.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Linear acceleration z value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: linearAccZ.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }
                
            }
        }

        // Angular tab content
        Item {

            RowLayout {
                spacing: 15
                anchors.leftMargin: 10
                anchors.left: parent.left


                // Position
                Rectangle { 
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Position:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15

                                Rectangle {
                                    width: rollLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: rollLabelPos
                                        text: "Roll:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: pitchLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: pitchLabelPos
                                        text: "Pitch:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yawLabelPos.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yawLabelPos
                                        text: "Yaw:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Angular position roll value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularPosRoll.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular position pitch value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularPosPitch.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular position yaw value
                                Rectangle {
                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        text: angularPosYaw.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }
                
                // Velocity
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Velocity:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15

                                Rectangle {
                                    width: rollLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: rollLabelVel
                                        text: "Roll:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: pitchLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: pitchLabelVel
                                        text: "Pitch:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yawLabelVel.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yawLabelVel
                                        text: "Yaw:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Angular velocity roll value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularVelRoll.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular velocity pitch value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularVelPitch.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular velocity yaw value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularVelYaw.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }

                // Acceleration
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 180
                    height: 180
                    
                    ColumnLayout {
                        spacing: 10
                    
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text { text: "Acceleration:" }
                        
                        RowLayout {
                            spacing: 5
                            
                            ColumnLayout {
                                spacing: 15
                                
                                Rectangle {
                                    width: rollLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: rollLabelAcc
                                        text: "Roll:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: pitchLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: pitchLabelAcc
                                        text: "Pitch:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                Rectangle {
                                    width: yawLabelAcc.width
                                    height: dataDisplayHeight
                                    
                                    Text {
                                        id: yawLabelAcc
                                        text: "Yaw:"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                            
                            ColumnLayout {
                                spacing: 15
                                
                                // Angular acceleration roll value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularAccRoll.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular acceleration pitch value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularAccPitch.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // Angular acceleration yaw value
                                Rectangle {
                                    width: dataDisplayWidth
                                    height: dataDisplayHeight

                                    border.color: "black"
                                    border.width: 1
                                    radius: 5
                                    
                                    Text {
                                        text: angularAccYaw.toFixed(3)
                                        anchors.leftMargin: 10
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                }
            }
        }

        // Misc tab content
        Item {

            RowLayout {
                anchors.leftMargin: 10
                anchors.left: parent.left
                Rectangle { 
                    border.color: "black"
                    border.width: 1
                    radius: 5
                    width: 280
                    height: 180
                
                    RowLayout {
                        spacing: 5

                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        
                        ColumnLayout {
                            spacing: 15

                            Rectangle {
                                width: integrityLabel.width
                                height: dataDisplayHeight
                                
                                Text {
                                    id: integrityLabel
                                    text: "Integrity:"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle {
                                width: numSatVistaLabel.width
                                height: dataDisplayHeight
                                
                                Text {
                                    id: numSatVistaLabel
                                    text: "Num. sat. vista:"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle {
                                width: sbasCorrLabel.width
                                height: dataDisplayHeight
                                
                                Text {
                                    id: sbasCorrLabel
                                    text: "SBAS correction:"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                        
                        ColumnLayout {
                            spacing: 15
                            
                            // Integrity value
                            Rectangle {
                                width: dataDisplayWidth
                                height: dataDisplayHeight

                                border.color: "black"
                                border.width: 1
                                radius: 5
                                
                                Text {
                                    text: miscIntegrity.toFixed(3)
                                    anchors.leftMargin: 10
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            // Num. sat. vista value
                            Rectangle {
                                width: dataDisplayWidth
                                height: dataDisplayHeight

                                border.color: "black"
                                border.width: 1
                                radius: 5
                                
                                Text {
                                    text: miscNumSatVista
                                    anchors.leftMargin: 10
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            // SBAS Correction value
                            Rectangle {
                                width: dataDisplayWidth
                                height: dataDisplayHeight

                                color: miscSbasCorrection ? "green" : "red"
                                
                                border.color: "black"
                                border.width: 1
                                radius: 5
                            }
                        }
                    }
                }
            }
        }
    }

}
