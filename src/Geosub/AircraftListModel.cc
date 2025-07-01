#include "AircraftListModel.h"

AircraftListModel::AircraftListModel(QObject *parent) : QAbstractListModel(parent)
{
}

int AircraftListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_aircraftList.count();
}

QVariant AircraftListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_aircraftList.count())
        return QVariant();

    const AircraftData &aircraft = m_aircraftList.at(index.row());

    switch (role) {
    case CallsignRole:     return aircraft.callsign;
    case LatitudeRole:     return aircraft.latitude;
    case LongitudeRole:    return aircraft.longitude;
    case AltitudeRole:     return aircraft.altitude;
    case HeadingRole:      return aircraft.heading;
    case HVelocityRole:    return aircraft.hVelocity;
    case VVelocityRole:    return aircraft.vVelocity;
    case ValidFlagsRole:   return aircraft.validFlags;
    case AltitudeTypeRole: return aircraft.altitudeType;
    case EmitterTypeRole:  return aircraft.emitterType;
    case TslcRole:         return aircraft.tslc;
    default:               return QVariant();
    }
}

QHash<int, QByteArray> AircraftListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CallsignRole] = "callsign";
    roles[LatitudeRole] = "latitude";
    roles[LongitudeRole] = "longitude";
    roles[AltitudeRole] = "altitude";
    roles[HeadingRole] = "heading";
    roles[HVelocityRole] = "hVelocity";
    roles[VVelocityRole] = "vVelocity";
    roles[ValidFlagsRole] = "validFlags";
    roles[AltitudeTypeRole] = "altitudeType";
    roles[EmitterTypeRole] = "emitterType";
    roles[TslcRole] = "tslc";
    return roles;
}

void AircraftListModel::addOrUpdateAircraft(const AircraftData &aircraft)
{
    if (m_callsignIndexMap.contains(aircraft.callsign)) {
        // Actualización existente
        int index = m_callsignIndexMap.value(aircraft.callsign);
        if (index >= 0 && index < m_aircraftList.size()) {
            m_aircraftList[index] = aircraft;
            QModelIndex modelIndex = createIndex(index, 0);
            emit dataChanged(modelIndex, modelIndex);
        }
    } else {
        // Nueva aeronave
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_aircraftList.append(aircraft);
        m_callsignIndexMap[aircraft.callsign] = m_aircraftList.size() - 1;
        endInsertRows();
    }
}

void AircraftListModel::removeAircraft(const QString &callsign)
{
    if (!m_callsignIndexMap.contains(callsign))
        return;

    int index = m_callsignIndexMap.take(callsign);

    beginRemoveRows(QModelIndex(), index, index);
    m_aircraftList.removeAt(index);

    // Actualizar índices en el mapa
    for (int i = index; i < m_aircraftList.size(); ++i) {
        m_callsignIndexMap[m_aircraftList[i].callsign] = i;
    }

    endRemoveRows();
}
void AircraftListModel::clearAll()
{
    beginResetModel();
    m_aircraftList.clear();
    m_callsignIndexMap.clear();
    endResetModel();
}

AircraftData AircraftListModel::getAircraft(int index) const
{
    if (index >= 0 && index < m_aircraftList.size()) {
        return m_aircraftList.at(index);
    }
    return AircraftData(); // Retorna estructura vacía si el índice no es válido
}

