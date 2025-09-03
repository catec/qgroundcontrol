add_custom_target(GeosubWidgetsQml
	SOURCES
		GICAWidget.qml
		TrafficViewerWidget.qml
)

add_library(Geosub
	GICA.h
	GICA.cc
	FuelManager.h
	FuelManager.cc
	ADSB.h
	ADSB.cc
	TrafficViewer.h
	TrafficViewer.cc
	AircraftListModel.h
	AircraftListModel.cc
)
find_package(Qt5 COMPONENTS Quick Location REQUIRED)
target_link_libraries(MyApp PRIVATE Qt5::Quick Qt5::Location)
