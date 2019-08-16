import ballerina/http;

public listener http:Listener wum_server_listener = new(9090);

public type ServerConfig record {
    int channels_port = 9090;
    int products_port = 9091;
    int subscriptions_port = 9092;
    int updates_port = 9093;
    int versions_port = 9094;
};