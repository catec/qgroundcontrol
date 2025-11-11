#pragma once

#include <QObject>
#include <QTimer>
#include <QRandomGenerator>

class PCGicaManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString statusText READ statusText NOTIFY statusTextChanged)
    Q_PROPERTY(QString color READ color NOTIFY colorChanged)

public:
    explicit PCGicaManager(QObject* parent = nullptr);

    QString statusText() const { return _statusText; }
    QString color() const { return _color; }

public slots:
    void onAutopilotConnected(bool connected); // Llamar cuando QGC detecte conexión
    void resetToUnknown();                     // Estado inicial o pérdida conexión

signals:
    void statusTextChanged(const QString& text);
    void colorChanged(const QString& color);
    void gicaOkChanged(bool ok); // Para el futuro indicador en el mapa

private slots:
    void _setConnecting();
    void _setOk();
    void _setDisconnected();

private:
    void _update(const QString& text, const QString& color);

    QString _statusText;
    QString _color;
    QTimer _connectingTimer;
    bool _autopilotConnected = false;
};
