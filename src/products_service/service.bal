// A system module containing protocol access constructs
// Module objects referenced with 'http:' in code
import ballerina/http;
import ballerina/io;
import ballerinax/java.jdbc;
import server_core;

listener http:Listener wum_server_listener = server_core:getServerListener();
// jdbc:Client dbClient = server_core:getProductsDbClient();
jdbc:Client dbClient = new({
    url: "jdbc:mysql://localhost:3306/productsdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});


service products on wum_server_listener {
    # A resource is an invokable API method
    # Accessible at '/products/getProducts
    # 'caller' is the client invoking this resource 

    # + caller - Server Connector
    # + request - Request
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/getProducts",
        produces: ["application/json"],
        auth: {
            scopes: ["hello"],
            enabled: true
        }
    }
    resource function getProducts(http:Caller caller, http:Request request) {
        var products = dbClient->select("SELECT * FROM products", server_core:Products);
        if (products is table<server_core:Products>) {
            var jsonProducts = typedesc<json>.constructFrom(products);
            if (jsonProducts is json) {
                error? result = caller->respond(<@untainted> jsonProducts);
                if (result is error) {
                    io:println("Error in responding", result);
                }
                return;
            }
        }
        error? result = caller->respond({});
        if (result is error) {
            io:println("Error in responding", result);
        }
    }

    # A resource is an invokable API method
    # Accessible at '/products/search
    # 'caller' is the client invoking this resource 

    # + caller - Server Connector
    # + request - Request
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/search/{productName}/version/{productVersion}",
        produces: ["application/json"],
        auth: {
            scopes: ["hello"],
            enabled: true
        }
    }
    resource function searchProducts(http:Caller caller, http:Request request, string productName, string productVersion) {

        // do proper taint checking
        string whereClause = " ";
        if ((productName != "*") || (productVersion != "*")) {
            whereClause = " WHERE";
            if (productName  != "*") {
                whereClause += " product_name=\"" + productName + "\"";
                if (productVersion  != "*") {
                    whereClause += " AND product_version=\"" + productVersion + "\"";
                }
            } else if (productVersion  != "*") {
                whereClause += " product_version=\"" + productVersion + "\"";
            }
        }

        var products = dbClient->select("SELECT * FROM products" + <@untiant> whereClause, server_core:Products);
        if (products is table<server_core:Products>) {
            var jsonProducts = typedesc<json>.constructFrom(products);
            if (jsonProducts is json) {
                error? result = caller->respond(<@untainted> jsonProducts);
                if (result is error) {
                    io:println("Error in responding", result);
                }
                return;
            }
        }
        error? result = caller->respond({});
        if (result is error) {
            io:println("Error in responding", result);
        }
    }

    # A resource is an invokable API method
    # Accessible at '/products/getFiles
    # 'caller' is the client invoking this resource 

    # + caller - Server Connector
    # + request - Request
    resource function getFiles(http:Caller caller, http:Request request) {

        var files = dbClient->select("SELECT * FROM files", server_core:Files);
        if (files is table<server_core:Files>) {
            var jsonFiles = typedesc<json>.constructFrom(files);
            if (jsonFiles is json) {
                error? result = caller->respond(<@untainted> jsonFiles);
                if (result is error) {
                    io:println("Error in responding", result);
                }
                return;
            }
        }

        error? result = caller->respond({});
        if (result is error) {
            io:println("Error in responding", result);
        }
    }

    # A resource is an invokable API method
    # Accessible at '/products/getUpdates
    # 'caller' is the client invoking this resource 

    # + caller - Server Connector
    # + request - Request
    resource function getUpdates(http:Caller caller, http:Request request) {
        var updates = dbClient->select("SELECT * FROM update_list", server_core:UpdateList);
        if (updates is table<server_core:UpdateList>) {
            var jsonUpdates = typedesc<json>.constructFrom(updates);
            if (jsonUpdates is json) {
                error? result = caller->respond(<@untainted> jsonUpdates);
                if (result is error) {
                    io:println("Error in responding", result);
                }
                return;
            }
        }
        
        error? result = caller->respond({});
        if (result is error) {
            io:println("Error in responding", result);
        }
    }
}
