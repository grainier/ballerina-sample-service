// A system module containing protocol access constructs
// Module objects referenced with 'http:' in code
import ballerina/http;
import ballerina/io;
import ballerinax/java.jdbc;
import server_core;

listener http:Listener wum_server_listener = server_core:getServerListener();
// jdbc:Client dbClient = server_core:getVersionsDbClient();

service versions on wum_server_listener {

    # A resource is an invokable API method
    # Accessible at '/versions/test
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
