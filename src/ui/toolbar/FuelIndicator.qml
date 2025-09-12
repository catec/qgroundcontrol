import QtQuick          2.11
import QtQuick.Layouts  1.11

import QGroundControl              1.0
import QGroundControl.Controls     1.0
import QGroundControl.ScreenTools  1.0
import QGroundControl.Palette      1.0
import QGroundControl.Fuel 1.0

Item {
    property real fuelPercent: FuelManager.fuelPercent
    property double burnRate: 100 / (3 * 60 * 60)
    property bool timerRunning: false
    id: _root
    anchors.top:    parent.top
    anchors.bottom: parent.bottom
    width:          fuelRow.width
    focus: true

    Timer {
        
            interval: 1000
            repeat: true
            running: timerRunning
            onTriggered: { 
                if (fuelPercent > 0) {
                    fuelPercent = Math.max(0, fuelPercent - burnRate)
                    FuelManager.fuelPercent = fuelPercent
                    FuelManager.saveFuel()
                }
            }
        
    }
    Shortcut {
        sequence: "Ctrl+F"
        onActivated: {
            timerRunning = !timerRunning
            console.log("Timer " + (timerRunning ? "iniciado" : "parado"))
        }
    }
    Row {
        id: fuelRow
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 4

        QGCColoredImage {
            anchors.top:        parent.top
            anchors.bottom:     parent.bottom
            width:              height
            sourceSize.width:   width
            source: "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 72 72'><style type='text/css'>.bg{fill:none;stroke:%23FFFFFF;stroke-width:4;stroke-miterlimit:10;}.needle{fill:none;stroke:%23FFFFFF;stroke-width:3;stroke-linecap:round;}.marks{fill:none;stroke:%23FFFFFF;stroke-width:2;}</style><path class='needle' d='M12 48 A24 24 0 0 1 60 48'/><line class='needle' x1='36' y1='48' x2='50' y2='35'/><text x='10' y='55' font-family='sans-serif' font-size='6' fill='%23FFFFFF'>E</text><text x='58' y='55' font-family='sans-serif' font-size='6' fill='%23FFFFFF'>F</text></svg>"
            fillMode:           Image.PreserveAspectFit
            color: fuelPercent > 20 ? qgcPal.text : qgcPal.colorRed
        }

        QGCLabel {
            text: fuelPercent.toFixed(1) + "%"
            font.pointSize: ScreenTools.mediumFontPointSize
            color: fuelPercent > 20 ? qgcPal.text : qgcPal.colorRed
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            mainWindow.showIndicatorPopup(_root, fuelPopup)
        }
    }

    Component {
        id: fuelPopup

        Rectangle {
            width: 200
            height: 100
            radius: ScreenTools.defaultFontPixelHeight / 2
            color: qgcPal.window
            border.color: qgcPal.text

            ColumnLayout {
                anchors.centerIn: parent
                spacing: ScreenTools.defaultFontPixelHeight

                QGCLabel {
                    Layout.alignment: Qt.AlignCenter
                    text: qsTr("Fuel Status")
                    font.family: ScreenTools.demiboldFontFamily
                }

                QGCLabel {
                    text: qsTr("Remaining: %1%").arg(fuelPercent.toFixed(1))
                }
            }
        }
    }
}
