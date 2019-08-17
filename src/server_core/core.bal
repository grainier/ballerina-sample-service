import ballerina/http;
import ballerina/jwt;
import ballerinax/java.jdbc;

jdbc:Client channelsDbClient = new({
    url: "jdbc:mysql://localhost:3306/channelsdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

jdbc:Client productsDbClient = new({
    url: "jdbc:mysql://localhost:3306/productsdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

jdbc:Client subscriptionsDbClient = new({
    url: "jdbc:mysql://localhost:3306/subscriptiondb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

jdbc:Client updatesDbClient = new({
    url: "jdbc:mysql://localhost:3306/updatesdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

jdbc:Client versionsDbClient = new({
    url: "jdbc:mysql://localhost:3306/versionsdb_300_wso2umuat?useTimezone=true&serverTimezone=UTC",
    username: "root",
    password: "root",
    poolOptions: { maximumPoolSize: 5 },
    dbOptions: { useSSL: false }
});

jwt:JwtTrustStoreConfig trustStoreConfig = {
    certificateAlias: "ballerina",
    trustStore: {
        path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
        password: "ballerina"
    }
};

jwt:JwtValidatorConfig validatorConf = {
    issuer: "ballerina",
    audience: "ballerina.io",
    trustStoreConfig: trustStoreConfig
};

jwt:InboundJwtAuthProvider jwtAuthProvider = new(validatorConf);
http:BearerAuthHandler jwtAuthHandler = new(jwtAuthProvider);

listener http:Listener wum_server_listener = new(9090, config = {
    auth: {
        authHandlers: [jwtAuthHandler]
    },

    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

public function getServerListener() returns http:Listener{
    return <@untainted> wum_server_listener;
}

public function getChannelsDbClient() returns jdbc:Client{
    return channelsDbClient;
}

public function getProductsDbClient() returns jdbc:Client{
    return productsDbClient;
}

public function getSubscriptionsDbClient() returns jdbc:Client{
    return subscriptionsDbClient;
}

public function getUpdatesDbClient() returns jdbc:Client{
    return updatesDbClient;
}

public function getVersionsDbClient() returns jdbc:Client{
    return versionsDbClient;
}