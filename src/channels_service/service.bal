import ballerina/http;
import ballerina/io;
import ballerinax/java.jdbc;
import server_core;

server_core:ServerConfig conf = {};

jdbc:Client dbClient = new({
    url: "jdbc:mysql://localhost:3306/channelsdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

service channels on new http:Listener(conf.channels_port) {
// service channels on server_core:wum_server_listener {

    # A resource is an invokable API method
    # Accessible at '/channels/test
    # 'caller' is the client invoking this resource 
    # 
    # + caller - Server Connector
    # + request - Request
    resource function test(http:Caller caller, http:Request request) {
        error? result = caller->respond("success");
        if (result is error) {
            io:println("Error in responding", result);
        }
    }
}
