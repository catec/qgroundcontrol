// PCGicaIndicator.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QGroundControl.PCGica 1.0

Item {
    id: root
    width: 180
    height: 40

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: PCGicaManager.color
        opacity: 0.8
        width: textItem.paintedWidth + 16    // margen horizontal
        height: textItem.paintedHeight + 8   // margen vertical
        Row {
            anchors.centerIn: parent
            spacing: 8

            Text {
                id: textItem
                text: PCGicaManager.statusText
                color: "white"
                font.bold: true
                font.pixelSize: 14
                anchors.centerIn: parent
            }
        }
    }
}
