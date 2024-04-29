public interface IProjectService
{
    Task<Project?> GetProjectById(Guid id, string version);
    Task<IEnumerable<Project>> GetAllProjects();
}
