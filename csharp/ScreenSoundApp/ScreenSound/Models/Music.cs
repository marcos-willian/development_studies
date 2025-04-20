using System.Reflection;
using System.Text.Json.Serialization;
using System.Text.Json.Serialization.Metadata;
using System.Xml.Linq;

namespace ScreenSound.Models;


[JsonNumberHandling(JsonNumberHandling.AllowReadingFromString)]
internal class Music
{
    [JsonInclude]
    private double popularity;
    [JsonInclude]
    private string genre = "";
    [JsonInclude]
    private double danceability;
    [JsonInclude]
    private double energy;
    [JsonInclude]
    private double speechiness;
    [JsonInclude]
    private double instrumentalness;
    [JsonInclude]
    private double acousticness;
    [JsonInclude]
    private double liveness;
    [JsonInclude]
    private double valence;

    [JsonPropertyName("song")]
    public required string Name { get; init; }

    [JsonPropertyName("artist")]
    public string BandName
    {
        init
        {
            NewBand?.Invoke(this, value);
            _bandName = value;
        }
        get => _bandName;
    }
    private readonly string _bandName = "";

    [JsonPropertyName("duration_ms")]
    public int Duration { get; init; }

    [JsonPropertyName("key")]
    public Key Key { get; init; }

    [JsonPropertyName("year")]
    public required string Year { get; init; }

    public SongCharacteristics SongCharacteristics => new(
            popularity,
            danceability,
            energy,
            speechiness,
            instrumentalness,
            acousticness,
            liveness,
            valence
        );

    public IEnumerable<string> Genres => genre.Split(',', StringSplitOptions.TrimEntries).ToList();


    public static event EventHandler<string>? NewBand;

}

