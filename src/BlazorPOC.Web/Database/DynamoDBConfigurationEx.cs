using Amazon.DynamoDBv2;

public static class DynamoDBConfigurationEX
{
    public static IServiceCollection AddDynamoDB(this IServiceCollection services, IConfiguration configuration)
    {
        var dbConfig = new AmazonDynamoDBConfig()
        {
            ServiceURL = configuration.GetValue<string>("AWS:ServiceURL"),
            AuthenticationRegion = configuration.GetValue<string>("AWS:Region")
        }; 

        services.Configure<DynamoDBSettings>(configuration.GetSection(DynamoDBSettings.KeyName));
        services.AddSingleton<IAmazonDynamoDB>(_ => new AmazonDynamoDBClient(dbConfig));
        
        return services;
    }
}