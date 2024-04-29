
using System.Text.Json;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DataModel;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using Microsoft.Extensions.Options;

public class ProjectService : IProjectService
{
    private readonly IAmazonDynamoDB _dynamoDb;

    private readonly IOptions<DynamoDBSettings> _databaseSettings;

    public ProjectService(IAmazonDynamoDB dynamoDb, IOptions<DynamoDBSettings> databaseSettings)
    {
        _dynamoDb = dynamoDb;
        _databaseSettings = databaseSettings;
    }

    public async Task<IEnumerable<Project>> GetAllProjects()
    {
        var request = new ScanRequest
        {
            TableName = _databaseSettings.Value.TableName
        };

        var response = await _dynamoDb.ScanAsync(request);
        
        return response.Items.Select(MapToProject).ToList()!;
    }

    public async Task<Project?> GetProjectById(Guid id, string version)
    {
        var request = new GetItemRequest
        {
            TableName = _databaseSettings.Value.TableName,
            Key = new Dictionary<string, AttributeValue>
            {
                { "projectId", new AttributeValue { S = id.ToString() } },
                { "version", new AttributeValue { S = version } }
            },
            ConsistentRead = true
        };

        var response = await _dynamoDb.GetItemAsync(request);
        return response.Item.Count == 0 ? null : MapToProject(response.Item);
    }

    private static Project? MapToProject(Dictionary<string, AttributeValue> item)
    {
        var itemAsDocument = Document.FromAttributeMap(item);
        var options = new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true 
        };
        return JsonSerializer.Deserialize<Project>(itemAsDocument.ToJson(), options);
    }
}   