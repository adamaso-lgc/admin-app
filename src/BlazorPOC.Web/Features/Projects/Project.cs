using System.Text.Json.Serialization;
using Amazon.DynamoDBv2.DataModel;

public class Project
{
    [DynamoDBHashKey("projectId")]
    public string ProjectId { get; set; }

    [DynamoDBRangeKey("version")]
    public string Version { get; set; }
    
    [DynamoDBProperty("name")]
    public string Name { get; set; }
    
    [DynamoDBProperty("status")]
    public string Status { get; set; }
    
    [DynamoDBProperty("lastDeploymentDate")]
    public DateTime LastDeploymentDate { get; set; }

}