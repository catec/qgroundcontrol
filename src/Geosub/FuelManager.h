#pragma once

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QStandardPaths>

class FuelManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(double fuelPercent READ fuelPercent WRITE setFuelPercent NOTIFY fuelPercentChanged)

public:
    explicit FuelManager(QObject* parent = nullptr);

    double fuelPercent() const { return _fuelPercent; }
    void setFuelPercent(double value);

    Q_INVOKABLE void saveFuel();

signals:
    void fuelPercentChanged();

private:
    double _fuelPercent;
    QString _fuelFilePath;
    void _loadFuel();
};
