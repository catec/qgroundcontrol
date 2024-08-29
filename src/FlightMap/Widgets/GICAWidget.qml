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

import QGroundControl.Geosub.GICA   1.0

ColumnLayout {
    property real dataDisplayHeight : 25
    property real dataDisplayWidth  : 100

    spacing: 10

    anchors.top: parent.top
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    
    // Vertical separator
    Rectangle {
        width: 1
        height: 5
        color: "transparent"
    }

    Text { text: "Linear" ; color: qgcPal.text }

    // Linear content
    RowLayout {
        spacing: 15
        
        // Position
        Rectangle { 
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Position:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15

                        Rectangle {
                            width: xLabelPos.width
                            height: dataDisplayHeight

                            color: "transparent"
                            
                            Text {
                                id: xLabelPos
                                text: "X:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yLabelPos.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yLabelPos
                                text: "Y:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: zLabelPos.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: zLabelPos
                                text: "Z:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.linearPosX.toFixed(4)
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
                                text: gica.linearPosY.toFixed(4)
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
                                text: gica.linearPosZ.toFixed(4)
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
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Velocity:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15
                        Rectangle {
                            width: xLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: xLabelVel
                                text: "X:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yLabelVel
                                text: "Y:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: zLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: zLabelVel
                                text: "Z:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.linearVelX.toFixed(4)
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
                                text: gica.linearVelY.toFixed(4)
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
                                text: gica.linearVelZ.toFixed(4)
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
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Acceleration:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15
                        
                        Rectangle {
                            width: xLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: xLabelAcc
                                text: "X:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yLabelAcc
                                text: "Y:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: zLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: zLabelAcc
                                text: "Z:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.linearAccX.toFixed(4)
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
                                text: gica.linearAccY.toFixed(4)
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
                                text: gica.linearAccZ.toFixed(4)
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
    
    // Vertical separator
    Rectangle {
        width: 1
        height: 5
        color: "transparent"
    }

    Text { text: "Angular" ; color: qgcPal.text}

    // Angular content
    RowLayout {
        spacing: 15

        // Position
        Rectangle { 
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Position:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15

                        Rectangle {
                            width: rollLabelPos.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: rollLabelPos
                                text: "Roll:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: pitchLabelPos.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: pitchLabelPos
                                text: "Pitch:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yawLabelPos.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yawLabelPos
                                text: "Yaw:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.angularPosRoll.toFixed(4)
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
                                text: gica.angularPosPitch.toFixed(4)
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
                                text: gica.angularPosYaw.toFixed(4)
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
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Velocity:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15

                        Rectangle {
                            width: rollLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: rollLabelVel
                                text: "Roll:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: pitchLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: pitchLabelVel
                                text: "Pitch:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yawLabelVel.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yawLabelVel
                                text: "Yaw:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.angularVelRoll.toFixed(4)
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
                                text: gica.angularVelPitch.toFixed(4)
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
                                text: gica.angularVelYaw.toFixed(4)
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
            radius: 5
            color: qgcPal.windowShade
            width: 180
            height: 180
            
            ColumnLayout {
                spacing: 10
            
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                
                Text { text: "Acceleration:"; color: qgcPal.text }
                
                RowLayout {
                    spacing: 5
                    
                    ColumnLayout {
                        spacing: 15
                        
                        Rectangle {
                            width: rollLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: rollLabelAcc
                                text: "Roll:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: pitchLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: pitchLabelAcc
                                text: "Pitch:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
                            }
                        }

                        Rectangle {
                            width: yawLabelAcc.width
                            height: dataDisplayHeight
                            
                            color: "transparent"
                            
                            Text {
                                id: yawLabelAcc
                                text: "Yaw:"
                                anchors.verticalCenter: parent.verticalCenter
                                color: qgcPal.text
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
                                text: gica.angularAccRoll.toFixed(4)
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
                                text: gica.angularAccPitch.toFixed(4)
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
                                text: gica.angularAccYaw.toFixed(4)
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
    
    // Vertical separator
    Rectangle {
        width: 1
        height: 5
        color: "transparent"
    }

    Text { text: "Misc." ; color: qgcPal.text }

    // Misc content
    RowLayout {
        
        Rectangle { 
            radius: 5
            color: qgcPal.windowShade
            width: 570
            height: 140
        
            RowLayout {
                spacing: 5
                
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                
                ColumnLayout {
                    spacing: 15

                    Rectangle {
                        width: integrityLabel.width
                        height: dataDisplayHeight
                        
                        color: "transparent"
                        
                        Text {
                            id: integrityLabel
                            text: "Integrity:"
                            anchors.verticalCenter: parent.verticalCenter
                            color: qgcPal.text
                        }
                    }

                    Rectangle {
                        width: numSatLabel.width
                        height: dataDisplayHeight
                        
                        color: "transparent"
                        
                        Text {
                            id: numSatLabel
                            text: "Number of satellites:"
                            anchors.verticalCenter: parent.verticalCenter
                            color: qgcPal.text
                        }
                    }

                    Rectangle {
                        width: sbasCorrLabel.width
                        height: dataDisplayHeight
                        
                        color: "transparent"
                        
                        Text {
                            id: sbasCorrLabel
                            text: "SBAS correction:"
                            anchors.verticalCenter: parent.verticalCenter
                            color: qgcPal.text
                        }
                    }
                }
                
                ColumnLayout {
                    spacing: 15
                    
                    // Integrity value
                    Rectangle {
                        width: dataDisplayWidth
                        height: dataDisplayHeight

                        // border.color: "black"
                        border.width: 1
                        radius: 5
                        
                        Text {
                            text: gica.miscIntegrity.toFixed(4)
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // Num. sat. value
                    Rectangle {
                        width: dataDisplayWidth
                        height: dataDisplayHeight

                        // border.color: "black"
                        border.width: 1
                        radius: 5
                        
                        Text {
                            text: gica.miscNumSat
                            anchors.leftMargin: 10
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // SBAS Correction value
                    Rectangle {
                        width: dataDisplayWidth
                        height: dataDisplayHeight

                        color: gica.miscSbasCorrection ? qgcPal.colorGreen : qgcPal.colorRed
                        
                        // border.color: "black"
                        border.width: 1
                        radius: 5
                    }
                }
            }
        }
    }

    // Vertical separator
    Rectangle {
        width: 1
        height: 5
        color: "transparent"
    }

    Text { 
        text: "Powered by:"
        color: qgcPal.text
        Layout.alignment: Qt.AlignHCenter 
    }

    Image {
        source: "qrc:///qmlimages/catecLogo.png"
        fillMode: Image.PreserveAspectFit
        Layout.preferredWidth: 100
        Layout.preferredHeight: 30
        Layout.alignment: Qt.AlignHCenter
    }

    Text { 
        text: "© CENTRO AVANZADO DE TECNOLOGÍAS AEROESPACIALES. \nReservados todos los derechos. \nEl contenido del presente software es propiedad de CATEC \ny no puede ser reproducido total ni parcialmente sin la expresa autorización del mismo. \nVAT: C91649616"
        color: qgcPal.text
        Layout.alignment: Qt.AlignHCenter
        horizontalAlignment: Text.AlignHCenter
    }

}
