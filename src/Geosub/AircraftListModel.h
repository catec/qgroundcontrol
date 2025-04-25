#ifndef AIRCRAFTLISTMODEL_H
#define AIRCRAFTLISTMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVariantMap>

struct AircraftData {
    QString callsign;
    double latitude;
    double longitude;
    double altitude;
    double heading;
    double hVelocity;
    double vVelocity;
    bool validFlags;
    QString altitudeType;
    QString emitterType;
    int tslc;
};

class AircraftListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum AircraftRoles {
        CallsignRole = Qt::UserRole + 1,
        //CallsignRole,
        LatitudeRole,
        LongitudeRole,
        AltitudeRole,
        HeadingRole,
        HVelocityRole,
        VVelocityRole,
        ValidFlagsRole,
        AltitudeTypeRole,
        EmitterTypeRole,
        TslcRole
    };

    explicit AircraftListModel(QObject *parent = nullptr);

    // Métodos de QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Métodos para manipular los datos
    Q_INVOKABLE void addOrUpdateAircraft(const AircraftData &aircraft);
    Q_INVOKABLE void removeAircraft(const QString& callsign);
    Q_INVOKABLE void clearAll();
    Q_INVOKABLE AircraftData getAircraft(int index) const;
    Q_INVOKABLE int getCount() const { return rowCount(); }


protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<AircraftData> m_aircraftList;
    QHash<QString, int> m_callsignIndexMap; // Para búsqueda rápida por callsign
};

#endif // AIRCRAFTLISTMODEL_H
