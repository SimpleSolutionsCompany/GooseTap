namespace SSC.GooseTap.Api.Common;

public class ApiResponse<T>
{
    public bool Succeeded { get; set; }
    public string? Message { get; set; }
    public T? Data { get; set; }
    public List<string>? Errors { get; set; }

    private ApiResponse() { }
    private ApiResponse(T data, string? message = null)
    {
        Succeeded = true;
        Message = message;
        Data = data;
        Errors = null;
    }
    private ApiResponse(string message, List<string> errors)
    {
        Succeeded = false;
        Data= default;
        Message = message;
        Errors = errors;
    }
    public static ApiResponse<T> Success(T data, string? message = null)
    {
        return new ApiResponse<T>(data, message);
    }

    public static ApiResponse<T> Failure(string message, IEnumerable<string> errors)
    {
        return new ApiResponse<T>(message, errors.ToList());
    }

    public static ApiResponse<T> Failure(string message, string error)
    {
        return new ApiResponse<T>(message, new List<string> { error });
    }
    
}