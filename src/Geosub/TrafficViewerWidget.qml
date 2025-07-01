/*import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15*/

import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtLocation               5.3
import QtPositioning            5.3

import QGroundControl                       1.0
import QGroundControl.FlightMap             1.0

Rectangle {
    width: 1200
    height: 850

    /*Plugin {
        id: mapPlugin
        name: "osm"
        PluginParameter {
            name: "osm.mapping.providersrepository.address";
            value: "https://a.tile.openstreetmap.fr/hot/"
        }
        PluginParameter {
            name: "osm.mapping.highdpi_tiles";
            value: "false"
        }

        PluginParameter {
            name: "osm.mapping.providersrepository.disabled";
            value: "true"
        }
        PluginParameter {
            name: "osm.mapping.attribution";
            value: "true"
        }
    }*/

    Map {
        id: _map
        anchors.fill: parent
        center: QtPositioning.coordinate(41.408, 2.202)
        zoomLevel: 12
        //activeMapType: "Hybrid"
        //plugin: mapPlugin
        //property bool   isSatelliteMap:   true
        plugin:         Plugin { name: "QGroundControl" }


        function updateActiveMapType() {
            var settings =  QGroundControl.settingsManager.flightMapSettings
            var fullMapName = settings.mapProvider.value + " " + settings.mapType.value

            for (var i = 0; i < _map.supportedMapTypes.length; i++) {
                if (fullMapName === _map.supportedMapTypes[i].name) {
                    _map.activeMapType = _map.supportedMapTypes[i]
                    return
                }
            }
        }

        Component.onCompleted: {
            updateActiveMapType()
        }
        Connections {
            target:             QGroundControl.settingsManager.flightMapSettings.mapType
            onRawValueChanged:  updateActiveMapType()
        }

        Connections {
            target:             QGroundControl.settingsManager.flightMapSettings.mapProvider
            onRawValueChanged:  updateActiveMapType()
        }



        MouseArea {
        anchors.fill: parent
        onClicked: {
            trafficViewer.clickedAircraftCallsign = "";
            adsbInMessageContainer.visible = false;
        }
        }

        MapQuickItem {
            coordinate: QtPositioning.coordinate(trafficViewer.latitude, trafficViewer.longitude)
            anchorPoint.x: 12
            anchorPoint.y: 24
            visible: trafficViewer.latitude !== 0.0 && trafficViewer.longitude !== 0.0
            sourceItem: Image {
                id: planeIcon
                source: "qrc:///qmlimages/compassInstrumentArrow_orange.svg"
                width: 24
                height: 24
                //rotation: heading
            }
        }


        MapItemView{
            model: trafficViewer.aircraftListModel
            delegate: MapQuickItem{
                coordinate: QtPositioning.coordinate(model.latitude, model.longitude)
                anchorPoint.x: 12
                anchorPoint.y: 24

                sourceItem: Image {
                    source: "qrc:///qmlimages/compassInstrumentArrow.svg"
                    width: 24
                    height: 24
                    rotation: model.heading

                    Rectangle {
                        width: parent.width + 4
                        height: parent.height + 4
                        anchors.centerIn: parent
                        color: "transparent"
                        border.color: "yellow"
                        border.width: 2
                        visible: trafficViewer.clickedAircraftCallsign === model.callsign
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            adsbInMessageContainer.visible = true;
                            trafficViewer.clickedAircraftCallsign = model.callsign;
                        }
                    }
                }
            }
        }


    }

    // ADS-B In Message container
    Rectangle {
        id: adsbInMessageContainer
        visible: false
        width: contentADSBInColumn.implicitWidth + 20
        height: contentADSBInColumn.implicitHeight + 20
        x: 1000
        y: 300
        z: 999
        color: "#222222"
        opacity: 0.7
        radius: 12
        border.color: "#000000"
        border.width: 2

        Column{
            id: contentADSBInColumn
            spacing: 10
            anchors.fill: parent
            anchors.margins: 10

            Text {
                text: "Aircraft info"
                font.bold: true
                color: "white"
                font.pixelSize: 14
            }

            Column {
                spacing: 4

                Text { text: formatValue("Callsign", trafficViewer.callsignClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Latitude", Math.trunc(trafficViewer.latitudeClicked * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Longitude", Math.trunc(trafficViewer.longitudeClicked * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Altitude", trafficViewer.altitudeClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Heading", trafficViewer.headingClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("H Velocity", Math.trunc(trafficViewer.hVelocityClicked * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("V Velocity", Math.trunc(trafficViewer.vVelocityClicked * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Valid flags", trafficViewer.validFlagsClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Altitude type", trafficViewer.altitudeTypeClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Emitter type", trafficViewer.emitterTypeClicked); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("TSLC", trafficViewer.tslcClicked); color: "white"; font.pixelSize: 12 }
            }
        }
    }



    // Toggle Button for ADS-B Out Static & Dynamic info
    Button {
        id: toggleOverlayBtn
        text: adsbOutMessagesContainer.visible ? "Hide Info" : "Show Info"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: adsbOutMessagesContainer.visible = ! adsbOutMessagesContainer.visible
    }


    // ADS-B Out Messages container
    Rectangle {
        id: adsbOutMessagesContainer
        width: contentColumn.implicitWidth + 20
        x: 20
        y: 70
        z: 999
        color: "#222222"
        opacity: 0.7
        radius: 12
        border.color: "#000000"
        border.width: 2

        Column {
            id: contentColumn
            spacing: 10
            anchors.fill: parent
            anchors.margins: 10

            Text {
                text: "ADS-B Out Static"
                font.bold: true
                color: "white"
                font.pixelSize: 14
            }

            Column {
                spacing: 4
                Text { text: formatValue("ICAO", trafficViewer.ICAO); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Integrity", trafficViewer.integrity); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Stall Speed", trafficViewer.stallSpeed); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Callsign", trafficViewer.callsign); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Capability", trafficViewer.capability); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Emitter", trafficViewer.emitter); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Allow Encode", trafficViewer.alwEncode); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("GPS Lat Offset", trafficViewer.gpsLatOffs); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("GPS Lon Offset", trafficViewer.gpsLonOffs); color: "white"; font.pixelSize: 12 }
            }


            Rectangle {
                height: 1
                width: parent.width
                color: "#666"
            }

            Text {
                text: "ADS-B Out Dynamic"
                font.bold: true
                color: "white"
                font.pixelSize: 14
            }

            Column {
                spacing: 4
                Text { text: formatValue("UTC Time", trafficViewer.utctimeStr); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Latitude", Math.trunc(trafficViewer.latitude * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Longitude", Math.trunc(trafficViewer.longitude * 1000) / 1000); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Altitude (Pres)", trafficViewer.altPres); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Altitude (GNSS)", trafficViewer.altGNSS); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Acc Horiz", trafficViewer.accHoriz); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Acc Vert", trafficViewer.accVert); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Acc Vel", trafficViewer.accVel); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Vel Vert", trafficViewer.velVert); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("North/South VOG", trafficViewer.nsVog); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("East/West VOG", trafficViewer.ewVog); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("State", trafficViewer.state); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Squawk", trafficViewer.squawk); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Fix Type", trafficViewer.fixType); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Num Sats", trafficViewer.numSats); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("EM Status", trafficViewer.emStatus); color: "white"; font.pixelSize: 12 }
                Text { text: formatValue("Control", trafficViewer.control); color: "white"; font.pixelSize: 12 }
            }

        }

        implicitHeight: contentColumn.implicitHeight + 20

    }


    function formatValue(label, value, allowZero) {
        if (!trafficViewer.connectionAvailable || value === undefined || value === null) {
            //(!allowZero && (value === 0 || value === 0.0 || value === ""))) {
            return label + ": --";
        }

        if(label === "Latitude" || label === "Longitude"){
            if(value === 0.0){
                return label + ": --"
            }
        }

        return label + ": " + value;
    }

}



