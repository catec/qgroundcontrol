#include "Primecor.h"

Primecor::Primecor(RestClient* restClient): _restClient(restClient) {
    
}


void Primecor::manageMQTTData(std::string topic, std::string payload) {

    QJsonObject json;
    json.insert("trackerId", QString::fromStdString(SN_PRIMECOR));
    json.insert("buffer", QString::fromStdString(payload));

    _restClient->sendRequest(json, "/sendToCloud",  RestClient::APIMethod::POST);
}