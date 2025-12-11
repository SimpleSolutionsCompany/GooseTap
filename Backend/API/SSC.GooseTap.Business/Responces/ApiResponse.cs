namespace SSC.GooseTap.Business.Responces
{
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public T? Data { get; set; }
        public List<string>? Errors { get; set; }

        public ApiResponse() { }

        public ApiResponse(T data, string message = "")
        {
            Success = true;
            Message = message;
            Data = data;
        }

        public ApiResponse(string message)
        {
            Success = false;
            Message = message;
        }
        
        public ApiResponse(List<string> errors, string message = "Validation Failed")
        {
            Success = false;
            Message = message;
            Errors = errors;
        }
    }
}
