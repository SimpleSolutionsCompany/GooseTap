namespace SSC.GooseTap.Business.Models;

public class TelegramUserData
{
    [System.Text.Json.Serialization.JsonPropertyName("id")]
    public long Id { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("first_name")]
    public string FirstName { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("last_name")]
    public string? LastName { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("username")]
    public string? Username { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("photo_url")]
    public string? PhotoUrl { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("language_code")]
    public string? LanguageCode { get; set; }

    [System.Text.Json.Serialization.JsonPropertyName("allows_write_to_pm")]
    public bool AllowsWriteToPm { get; set; }

}