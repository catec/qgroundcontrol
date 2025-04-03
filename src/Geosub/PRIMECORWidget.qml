/** 
* @file
* @brief PRIMECOR widget implementation (frontend).
* @author Alejandro Pariente Migoya <alex_pariente@hotmail.es>
*/

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

ColumnLayout {
    spacing: 10
    anchors.fill: parent

    // Define tabs
    TabBar {
        id: tabBar
        Layout.fillWidth: true

        TabButton { text: "Operator"  }
        TabButton { text: "Pilot"     }
        TabButton { text: "Flight"    }
        TabButton { text: "Operation" }
    }

    // Tabs content
    StackLayout {

        Layout.fillWidth: true
        Layout.fillHeight: true

        currentIndex: tabBar.currentIndex



        // ~~~~~~~~~~~~~~~~~~~~~~~
        // ~~~~ Operator Tab ~~~~~
        // ~~~~~~~~~~~~~~~~~~~~~~~
        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "transparent"

            ScrollView {

                width: parent.width
                height: parent.height

                leftPadding: 80
                topPadding: 20
                bottomPadding: 20
                
                clip: true
                
                ColumnLayout {

                    anchors.centerIn: parent
                    spacing: 10


                    // ---------------------
                    // ---- getOperator ----
                    // ---------------------
                    Text {
                        text: "Get operator"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operator ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: getOperatorIdField
                            placeholderText: "Enter operator ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                getOperator(getOperatorIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: getOperatorResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // -----------------------
                    // ---- listOperators ----
                    // -----------------------
                    Text {
                        text: "List operators"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Button {
                            text: "List Operators"
                            onClicked: {
                                listOperators()
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: listOperatorsResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ---------------------
                    // ----- addPilot ------
                    // ---------------------
                    Text {
                        text: "Add pilot"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Pilot ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: addPilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                addPilot(addPilotIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: addPilotResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ------------------------
                    // ----- removePilot ------
                    // ------------------------
                    Text {
                        text: "Remove pilot"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Pilot ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: removePilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                removePilot(removePilotIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: removePilotResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ----------------------------
                    // ---- listOperatorPilots ----
                    // ----------------------------
                    Text {
                        text: "List operator pilots"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Button {
                            text: "List Operator Pilots"
                            onClicked: {
                                listOperatorPilots()
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: listOperatorPilotsResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ----------------------------
                    // ------ getUASOperator ------
                    // ----------------------------
                    Text {
                        text: "Get UAS operator"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Button {
                            text: "Get UAS Operator"
                            onClicked: {
                                getUASOperator()
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: getUASOperatorResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }

                }

            }

        }  // Operator tab




        // ~~~~~~~~~~~~~~~~~~~~~~~
        // ~~~~~~ Pilot Tab ~~~~~~
        // ~~~~~~~~~~~~~~~~~~~~~~~
        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "transparent"

            ScrollView {

                width: parent.width
                height: parent.height

                leftPadding: 80
                topPadding: 20
                bottomPadding: 20
                
                clip: true
                
                ColumnLayout {

                    anchors.centerIn: parent
                    spacing: 10


                    // ---------------------
                    // ---- createPilot ----
                    // ---------------------
                    Text {
                        text: "Create pilot"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "License:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createPilotLicenseField
                            placeholderText: "Enter pilot license"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "First name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createPilotFirstNameField
                            placeholderText: "Enter pilot first name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Last name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createPilotLastNameField
                            placeholderText: "Enter pilot last name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Email:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createPilotEmailField
                            placeholderText: "Enter pilot email"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Create pilot"
                        onClicked: {
                            createPilot(createPilotLicenseField.text, createPilotFirstNameField.text, createPilotLastNameField.text, createPilotEmailField.text)
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: createOperatorResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // -----------------------
                    // ---- listPilots ----
                    // -----------------------
                    Text {
                        text: "List pilots"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Button {
                            text: "List pilots"
                            onClicked: {
                                listPilots()
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: listPilotsResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ---------------------
                    // ----- getPilot ------
                    // ---------------------
                    Text {
                        text: "Get pilot"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Pilot ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: getPilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                getPilot(getPilotIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: getPilotResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ------------------------
                    // ----- updatePilot ------
                    // ------------------------
                    Text {
                        text: "Update pilot"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Pilot ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: updatePilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "License:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updatePilotLicenseField
                            placeholderText: "Enter pilot license"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "First name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updatePilotFirstNameField
                            placeholderText: "Enter pilot first name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Last name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updatePilotLastNameField
                            placeholderText: "Enter pilot last name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Email:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updatePilotEmailField
                            placeholderText: "Enter pilot email"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Update pilot"
                        onClicked: {
                            createPilot(
                                updatePilotIdField.text, 
                                updatePilotLicenseField.text, 
                                updatePilotFirstNameField.text, 
                                updatePilotLastNameField.text, 
                                updatePilotEmailField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: updatePilotResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ----------------------------
                    // -------- deletePilot -------
                    // ----------------------------
                    Text {
                        text: "Delete pilot"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Pilot ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: deletePilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                deletePilot(deletePilotIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: deletePilotResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }

                }

            }

        }  // Pilot tab




        // ~~~~~~~~~~~~~~~~~~~~~~~
        // ~~~~~ Flight Tab ~~~~~~
        // ~~~~~~~~~~~~~~~~~~~~~~~
        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "transparent"

            ScrollView {

                width: parent.width
                height: parent.height

                leftPadding: 80
                topPadding: 20
                bottomPadding: 20
                
                clip: true
                
                ColumnLayout {

                    anchors.centerIn: parent
                    spacing: 10


                    // ---------------------
                    // ---- createFlight ----
                    // ---------------------
                    Text {
                        text: "Create flight"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Pilot ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightPilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Email:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightPilotEmailField
                            placeholderText: "Enter pilot email"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "UAS ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightUASIdField
                            placeholderText: "Enter UAS ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Flight name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightNameField
                            placeholderText: "Enter flight name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Flight type:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightTypeField
                            placeholderText: "Enter flight type"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Departure date:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightDepartureDateField
                            placeholderText: "Enter flight departure date"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Arrival date:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createFlightArrivalDateField
                            placeholderText: "Enter flight arrival date"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Create flight"
                        onClicked: {
                            createFlight(
                                createFlightPilotIdField.text,
                                createFlightPilotEmailField.text,
                                createFlightUASIdField.text,
                                createFlightNameField.text,
                                createFlightTypeField.text,
                                createFlightDepartureDateField.text,
                                createFlightArrivalDateField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: createFlightResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }



                    // -----------------------
                    // ----- listFlights -----
                    // -----------------------
                    Text {
                        text: "List flights"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Operator ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: listFlightsOperatorIdField
                            placeholderText: "Enter operator ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                listFlights(listFlightsOperatorIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: listFlightsResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ---------------------
                    // ----- getFlight -----
                    // ---------------------
                    Text {
                        text: "Get flight"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Flight ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: getFlightFlightIdField
                            placeholderText: "Enter flight ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                getFlight(getFlightFlightIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: getFlightResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }


                    // ----------------------
                    // ---- updateFlight ----
                    // ----------------------
                    Text {
                        text: "Update flight"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Flight ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightFlightIdField
                            placeholderText: "Enter flight ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Pilot ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightPilotIdField
                            placeholderText: "Enter pilot ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Email:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightPilotEmailField
                            placeholderText: "Enter pilot email"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "UAS ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightUASIdField
                            placeholderText: "Enter UAS ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Flight name:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightNameField
                            placeholderText: "Enter flight name"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Flight type:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightTypeField
                            placeholderText: "Enter flight type"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Departure date:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightDepartureDateField
                            placeholderText: "Enter flight departure date"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Arrival date:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateFlightArrivalDateField
                            placeholderText: "Enter flight arrival date"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Update flight"
                        onClicked: {
                            updateFlight(
                                updateFlightFlightIdField.text,
                                updateFlightPilotIdField.text,
                                updateFlightPilotEmailField.text,
                                updateFlightUASIdField.text,
                                updateFlightNameField.text,
                                updateFlightTypeField.text,
                                updateFlightDepartureDateField.text,
                                updateFlightArrivalDateField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: updateFlightResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // ------------------------
                    // ----- deleteFlight -----
                    // ------------------------
                    Text {
                        text: "Delete flight"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Flight ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: deleteFlightFlightIdField
                            placeholderText: "Enter flight ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                deleteFlight(deleteFlightFlightIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: deleteFlightResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }
                }
            }
        }




        // ~~~~~~~~~~~~~~~~~~~~~~~
        // ~~~~ Operation Tab ~~~~
        // ~~~~~~~~~~~~~~~~~~~~~~~
        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "transparent"

            ScrollView {

                width: parent.width
                height: parent.height

                leftPadding: 80
                topPadding: 20
                bottomPadding: 20
                
                clip: true
                
                ColumnLayout {

                    anchors.centerIn: parent
                    spacing: 10




                    // -------------------------
                    // ---- createOperation ----
                    // -------------------------
                    Text {
                        text: "Create operation"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createOperationOperationNameField
                            placeholderText: "Enter operation"
                            Layout.fillWidth: true

                            onAccepted: {
                                createOperation(createOperationDescriptionField.text)
                            }
                        }
                    }

                    Button {
                        text: "Create operation"
                        onClicked: {
                            createOperation(
                                createOperationDescriptionField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: createOperationResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // --------------------------
                    // ----- listOperations -----
                    // --------------------------
                    Text {
                        text: "List operations"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Operator ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: listOperationsOperatorIdField
                            placeholderText: "Enter operator ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                listOperations(listOperationsOperatorIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: listOperationsResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }

                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // ------------------------
                    // ----- getOperation -----
                    // ------------------------
                    Text {
                        text: "Get operation"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Operation ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: getOperationOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                getOperation(getOperationOperationIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: getOperationResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // -------------------------
                    // ---- updateOperation ----
                    // -------------------------
                    Text {
                        text: "Update operation"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateOperationOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: updateOperationDescriptionField
                            placeholderText: "Enter operation"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Update operation"
                        onClicked: {
                            updateOperation(
                                updateOperationOperationIdField.text,
                                updateOperationDescriptionField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: updateOperationResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }




                    // ---------------------------
                    // ----- deleteOperation -----
                    // ---------------------------
                    Text {
                        text: "Delete operation"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Operation ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: deleteOperationOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                deleteOperation(deleteOperationOperationIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: deleteOperationResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // -----------------
                    // ---- addNode ----
                    // -----------------
                    Text {
                        text: "Add node"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: addNodeOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Node:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: addNodeDescriptionField
                            placeholderText: "Enter node"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Add node"
                        onClicked: {
                            addNode(
                                addNodeOperationIdField.text,
                                addNodeDescriptionField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: addNodeResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // --------------------
                    // ---- deleteNode ----
                    // --------------------
                    Text {
                        text: "Delete node"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: deleteNodeOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Node ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: deleteNodeNodeIdField
                            placeholderText: "Enter node ID"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Delete node"
                        onClicked: {
                            deleteNode(
                                deleteNodeOperationIdField.text,
                                deleteNodeNodeIdField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: deleteNodeResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // ------------------------
                    // ---- createGeofence ----
                    // ------------------------
                    Text {
                        text: "Create Geofence"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Operation ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createGeofenceOperationIdField
                            placeholderText: "Enter operation ID"
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        spacing: 10

                        Text { 
                            text: "Node ID:" 
                            color: qgcPal.text
                        }
                        
                        TextField {
                            id: createGeofenceNodeIdField
                            placeholderText: "Enter node ID"
                            Layout.fillWidth: true
                        }
                    }

                    Button {
                        text: "Create Geofence"
                        onClicked: {
                            createGeofence(
                                createGeofenceOperationIdField.text,
                                createGeofenceNodeIdField.text
                            )
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: createGeofenceResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // ---------------------------------
                    // ----- createOperationFlight -----
                    // ---------------------------------
                    Text {
                        text: "Create operation flight"
                        color: qgcPal.text
                        font.bold: true
                        font.pointSize: 18
                    }

                    RowLayout {
                        spacing: 10

                        Text { text: "Flight ID:"; color: qgcPal.text }
                        
                        TextField {
                            id: createOperationFlightFlightIdField
                            placeholderText: "Enter flight ID"
                            Layout.fillWidth: true

                            onAccepted: {
                                createOperationFlight(createOperationFlightFlightIdField.text)
                            }
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        Label {
                            id: createOperationFlightResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }




                    // -----------------------
                    // ---- makeOperation ----
                    // -----------------------
                    Text {
                        text: "Make operation"
                        font.bold: true
                        font.pointSize: 18
                        color: qgcPal.text
                    }

                    Button {
                        text: "Make operation"
                        onClicked: {
                            makeOperation()
                        }
                    }

                    // Result
                    RowLayout {
                        spacing: 10
                        Label {
                                text: "Result:"
                                color: qgcPal.text
                                wrapMode: Text.WordWrap
                        }

                        // Result
                        Label {
                            id: makeOperationResultLabel
                            text: ""
                            color: qgcPal.text
                            wrapMode: Text.WordWrap
                        }
                    }


                    // Separator
                    Rectangle {
                        width: 1
                        height: 5
                        color: "transparent"
                    }
                }
            }
        }
    }




    // Separador
    Rectangle {
        width: 1
        height: 5
        color: "transparent"
    }




    // Author rights
    ColumnLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        spacing: 5

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

        // Separador
        Rectangle {
            width: 1
            height: 25
            color: "transparent"
        }
    }
}
