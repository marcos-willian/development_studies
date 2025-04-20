
using ScreenSound.Models;
using System.Text.Json;
using System.Text.Json.Serialization.Metadata;

namespace ScreenSound.Services.API;

internal class MusicsApi : IMusicsApi
{
    public async Task<List<Music>> GetMusics()  
    {
         HttpClient client = new();
       

        string response = await client.GetStringAsync(
               "https://guilhermeonrails.github.io/api-csharp-songs/songs.json"
            );

        JsonSerializerOptions options = new()
        {
            IncludeFields = true,
        };
        return JsonSerializer.Deserialize<List<Music>>(
            response, 
            options: options
        ) ?? throw new FileLoadException("Falha ao carregar lista de musicas"); 
    }
}
