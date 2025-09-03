#include "FuelManager.h"

FuelManager::FuelManager(QObject* parent)
    : QObject(parent)
    , _fuelPercent(100.0) // default
{
    _fuelFilePath = "resources/Fuel.txt";
    _loadFuel();
}

void FuelManager::_loadFuel() {
    QFile file(_fuelFilePath);
    if (file.exists() && file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        bool ok = false;
        double val = in.readLine().toDouble(&ok);
        if (ok) {
            _fuelPercent = val;
        }
        file.close();
    }
}

void FuelManager::setFuelPercent(double value) {
    if (_fuelPercent != value) {
        _fuelPercent = value;
        emit fuelPercentChanged();
    }
}

void FuelManager::saveFuel() {
    QFile file(_fuelFilePath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << _fuelPercent << "\n";
        file.close();
    }
}
