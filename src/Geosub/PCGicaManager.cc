#include "PCGicaManager.h"

PCGicaManager::PCGicaManager(QObject* parent)
    : QObject(parent)
{
  _update("GPS Gica: Unknown", "#d9534f"); // rojo
  connect(&_connectingTimer, &QTimer::timeout, this, &PCGicaManager::_setOk);
}

void PCGicaManager::onAutopilotConnected(bool connected)
{
    if (connected == _autopilotConnected)
        return;

    _autopilotConnected = connected;

    if (connected) {
        _setConnecting();
    } else {
        _setDisconnected();
    }
}

void PCGicaManager::_setConnecting()
{
  _update("GPS Gica: Connecting...", "#f0ad4e"); // amarillo
  emit gicaOkChanged(false);

  int randomDelay = QRandomGenerator::global()->bounded(6000, 120001);
  _connectingTimer.setSingleShot(true);
  _connectingTimer.start(randomDelay);
}

void PCGicaManager::_setOk()
{
  _update("GPS Gica: OK", "#5cb85c"); // verde
  emit gicaOkChanged(true);
}

void PCGicaManager::_setDisconnected()
{
    _connectingTimer.stop();
    _update("GPS Gica: Disconnected", "#d9534f"); // rojo
    emit gicaOkChanged(false);
}

void PCGicaManager::resetToUnknown()
{
    _connectingTimer.stop();
    _update("GPS Gica: Unknown", "#d9534f");
    emit gicaOkChanged(false);
}

void PCGicaManager::_update(const QString& text, const QString& color)
{
    if (_statusText != text) {
        _statusText = text;
        emit statusTextChanged(_statusText);
    }
    if (_color != color) {
        _color = color;
        emit colorChanged(_color);
    }
}
